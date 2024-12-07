import 'package:h3_14_bookie/domain/model/app_user.dart';
import 'package:h3_14_bookie/domain/model/dto/user_dto.dart';
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
  Stream<QuerySnapshot<Object?>> getAppUsers() {
    return _appUserRef.snapshots();
  }

  @override
  Future<void> createAppUser(UserDto newUser) async {
    AppUser newAppUser = AppUser(
        authUserUid: newUser.authUserUid,
        name: newUser?.name,
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
  Future<void> addNewWriting(String storyId, bool isDraft) {
    // TODO: implement addNewWriting
    throw UnimplementedError();
  }

  @override
  Future<void> completeNewChapterInStory(
      String stroyId, String completedChapterUid) {
    // TODO: implement completeNewChapterInStory
    throw UnimplementedError();
  }
}
