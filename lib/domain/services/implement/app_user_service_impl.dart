import 'package:firebase_auth/firebase_auth.dart';
import 'package:h3_14_bookie/domain/model/app_user.dart';
import 'package:h3_14_bookie/domain/model/dto/user_dto.dart';
import 'package:h3_14_bookie/domain/model/writing.dart';
import 'package:h3_14_bookie/domain/services/app_user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h3_14_bookie/constants/collection_references.dart';

class AppUserServiceImpl implements IAppUserService {
  final db = FirebaseFirestore.instance;
  late final CollectionReference _appUserRef;

  AppUserServiceImpl() {
    _appUserRef = db
        .collection(CollectionReferences.APP_USER_COLLECTION_REF)
        .withConverter<AppUser>(
            fromFirestore: (snapshots, _) =>
                AppUser.fromFirestore(snapshots, _),
            toFirestore: (appUser, _) => appUser.toFirestore());
  }

  @override
  Future<List<AppUser>> getAppUsers() async {
    final docs = await _appUserRef.get();
    List<AppUser> appUsers = docs.docs.map((doc) {
      final appUser = (doc as DocumentSnapshot<AppUser>).data();
      if (appUser == null) {
        throw StateError('AppUser data is null');
      }
      return appUser;
    }).toList();
    return appUsers;
  }

  @override
  Future<AppUser?> getAppUserById(String uid) async {
    final doc = await _appUserRef.doc(uid).get() as DocumentSnapshot<AppUser>;
    if (doc.data() == null) {
      throw StateError('AppUser data is null');
    }
    final appUser = doc.data();
    if (appUser == null) {
      throw StateError('AppUser data is null');
    }
    return appUser;
  }

  @override
  Future<AppUser?> getAppUserByAuthUserUid(String authUserUid) async {
    try {
      final docs =
          await _appUserRef.where('authUserUid', isEqualTo: authUserUid).get();
      if (docs.docs.isEmpty) {
        throw StateError('AppUser not found');
      }

      final docSnapshot = docs.docs.first as DocumentSnapshot<AppUser>;
      final appUser = docSnapshot.data();

      if (appUser == null) {
        throw StateError('AppUser data is null');
      }

      return appUser;
    } catch (e) {
      print('Error getting AppUser: ${e.toString()}');
      return null;
    }
  }

  @override
  Future<String> getAppUserIdByAuthUserUid(String authUserUid) async {
    final docs =
        await _appUserRef.where('authUserUid', isEqualTo: authUserUid).get();
    return docs.docs.first.id;
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
  Future<void> updateAppUser(AppUser appUser) async {
    final appUserUid = await getAppUserIdByAuthUserUid(appUser.authUserUid!);
    _appUserRef.doc(appUserUid).update(appUser.toFirestore());
  }

  @override
  Future<void> updateUserWriting(Writing writing) async {
    final appUserUid = FirebaseAuth.instance.currentUser?.uid;
    if (appUserUid == null) {
      throw Exception('User not logged in');
    }
    final appUser = await getAppUserByAuthUserUid(appUserUid);
    if (appUser == null) {
      throw Exception('App user not found');
    }
    final writings = appUser.writings ?? [];
    final writingToUpdate =
        writings.firstWhere((w) => w.storyId == writing.storyId);
    final updatedWriting =
        Writing(storyId: writingToUpdate.storyId, isDraft: writing.isDraft);

    final writingIndex = writings.indexOf(writingToUpdate);

    writings[writingIndex] = updatedWriting;

    final writingMaps = writings.map((w) => w.toFirestore()).toList();

    _appUserRef.where('authUserUid', isEqualTo: appUserUid).get().then(
        (value) =>
            value.docs.first.reference.update({"writings": writingMaps}));
  }

  @override
  Future<void> addNewWriting(
      String authUserUid, String storyId, bool isDraft) async {
    final appUserList = await getAppUsers();
    final appUser =
        appUserList.firstWhere((appUser) => appUser.authUserUid == authUserUid);

    final writings = appUser.writings ?? [];
    final writing = Writing(storyId: storyId, isDraft: isDraft);
    writings.add(writing);
    final appUserDoc =
        await _appUserRef.where('authUserUid', isEqualTo: authUserUid).get();
    final appUserDocId = appUserDoc.docs.first.id;
    final writingMaps = writings.map((w) => w.toFirestore()).toList();
    await _appUserRef.doc(appUserDocId).update({"writings": writingMaps});
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

  @override
  Future<bool> deleteUserReading(String userUid, String readingStoryUid) async {
    final appUser = await getAppUserByAuthUserUid(userUid);
    final readings = appUser?.readings ?? [];
    if (readings.isEmpty) {
      return false;
    }
    try {
      final reading = readings.firstWhere((r) => r.storyId == readingStoryUid);
      final readingIndex = readings.indexOf(reading);
      readings.removeAt(readingIndex);

      final updatedAppUser =
          AppUser(authUserUid: appUser?.authUserUid, readings: readings);

      await updateAppUser(updatedAppUser);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> deleteUserWriting(
      String authUserUid, String writingStoryUid) async {
    final appUser = await getAppUserByAuthUserUid(authUserUid);
    final writings = appUser?.writings ?? [];
    if (writings.isEmpty) {
      return false;
    }
    try {
      final writing = writings.firstWhere((w) => w.storyId == writingStoryUid);
      final writingIndex = writings.indexOf(writing);
      writings.removeAt(writingIndex);

      final updatedAppUser = AppUser(
        authUserUid: appUser?.authUserUid,
        writings: writings,
      );

      await updateAppUser(updatedAppUser);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
