import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h3_14_bookie/domain/model/dto/user_dto.dart';
import 'package:h3_14_bookie/domain/model/reading.dart';

interface class IAppUserService {
  Stream<QuerySnapshot> getAppUsers() {
    return Stream.empty();
  }

  Future<void> createAppUser(UserDto newUser) async {}

  Future<void> updateUser(String uid, String name, String email) async {}

  Future<void> addNewReading(String storyId, bool inLibrary) async {}

  Future<void> addNewWriting(String storyId, bool isDraft) async {}

  Future<void> completeNewChapterInStory(
      String stroyId, String completedChapterUid) async {}
}
