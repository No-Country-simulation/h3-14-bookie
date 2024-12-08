import 'package:firebase_auth/firebase_auth.dart';
import 'package:h3_14_bookie/domain/model/app_user.dart';
import 'package:h3_14_bookie/domain/model/dto/user_dto.dart';
import 'package:h3_14_bookie/domain/model/writing.dart';
import 'package:h3_14_bookie/domain/services/app_user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String APP_USER_COLLECTION_REF = "appuser";

class AppUserServiceImpl implements IAppUserService {
  final db = FirebaseFirestore.instance;

  late final CollectionReference _appUserRef;

  AppUserServiceImpl() {
    _appUserRef = db.collection(APP_USER_COLLECTION_REF).withConverter<AppUser>(
        fromFirestore: (snapshots, _) => AppUser.fromFirestore(snapshots, _),
        toFirestore: (appUser, _) => appUser.toFirestore());
  }

  @override
  Future<List<AppUser>> getAppUsers() async {
    final docs = await _appUserRef.get();
    return docs.docs.map((doc) {
      final appUser = (doc as DocumentSnapshot<AppUser>).data();
      if (appUser == null) {
        throw StateError('AppUser data is null');
      }
      return appUser;
    }).toList();
  }

  @override
  Future<AppUser?> getAppUserById(String uid) async {
    final doc = await _appUserRef.doc(uid).get() as DocumentSnapshot<AppUser>;
    return doc.data();
  }

  @override
  Future<void> createAppUser(UserDto newUser) async {
    AppUser newAppUser = AppUser(
        authUserUid: newUser.authUserUid,
        name: newUser.name,
        email: newUser.email);
    _appUserRef.add(newAppUser);
  }

  @override
  Future<void> updateUser(String uid, String name, String email) async {
    _appUserRef.doc(uid).update({"name": name, "email": email});
  }

  @override
  Future<void> addNewReading(String storyId, bool inLibrary) {
    // TODO: implement addNewReading
    throw UnimplementedError();
  }

  @override
  Future<void> addNewWriting(
      String authUserUid, String storyId, bool isDraft) async {
    final appUserList = await getAppUsers();
    final appUser =
        appUserList.firstWhere((appUser) => appUser.authUserUid == authUserUid);

    final writings = appUser.writings ?? [];
    writings.add(Writing(storyId: storyId, isDraft: isDraft));
    await _appUserRef.doc(authUserUid).update({"writings": writings});
  }

  @override
  Future<List<Writing>> getAuthorWritings(String authorUid) async {
    final appUserList = await getAppUsers();
    final appUser =
        appUserList.firstWhere((appUser) => appUser.authUserUid == authorUid);
    return appUser.writings ?? [];
  }

  @override
  Future<void> completeNewChapterInStory(
      String stroyId, String completedChapterUid) {
    // TODO: implement completeNewChapterInStory
    throw UnimplementedError();
  }
}
