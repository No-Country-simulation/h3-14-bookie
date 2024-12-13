import 'package:firebase_auth/firebase_auth.dart';
import 'package:h3_14_bookie/domain/model/app_user.dart';
import 'package:h3_14_bookie/domain/model/reading.dart';
import 'package:h3_14_bookie/domain/model/story.dart';
import 'package:h3_14_bookie/domain/services/app_user_service.dart';
import 'package:h3_14_bookie/domain/services/chapter_service.dart';
import 'package:h3_14_bookie/domain/services/implement/app_user_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/chapter_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/story_service_impl.dart';
import 'package:h3_14_bookie/domain/services/reading_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h3_14_bookie/domain/services/story_service.dart';

class ReadingServiceImpl implements IReadingService {
  final db = FirebaseFirestore.instance;
  final IAppUserService appUserService = AppUserServiceImpl();
  final IChapterService chapterService = ChapterServiceImpl();
  final IStoryService storyService = StoryServiceImpl();

  ReadingServiceImpl();

  @override
  Future<List<Reading>> getUserReadings(bool? inLibrary) async {
    final appUser = await appUserService
        .getAppUserByAuthUserUid(FirebaseAuth.instance.currentUser?.uid ?? "");
    if (appUser == null) {
      throw Exception('AppUser not found');
    }
    if (inLibrary == null) {
      return appUser.readings ?? [];
    }
    final readings = appUser.readings;
    return readings
            ?.where((reading) => reading.inLibrary == inLibrary)
            .toList() ??
        [];
  }

  @override
  Future<bool> addNewReading(String storyId, bool inLibrary) async {
    final authUserUid = FirebaseAuth.instance.currentUser?.uid;
    if (authUserUid == null) {
      throw Exception('User not logged in');
    }
    final appUser = await appUserService.getAppUserByAuthUserUid(authUserUid);
    if (appUser == null) {
      throw Exception('App user not found');
    }
    final readings = appUser.readings ?? [];

    final firstChapterUid = await chapterService
        .getChapterUidByStoryUidAndChapterNumber(storyId, 1);
    final newReading = Reading(
        storyId: storyId,
        inLibrary: inLibrary,
        readingChaptersUids: [firstChapterUid]);
    readings.add(newReading);

    final appUserUpdate =
        AppUser(authUserUid: appUser.authUserUid, readings: readings);

    await appUserService.updateAppUser(appUserUpdate);

    final story = await storyService.getStoryById(storyId);
    await storyService.updateStory(
        storyId, Story(totalReadings: (story?.totalReadings ?? 0) + 1));

    return true;
  }

  @override
  Future<bool> updateInLibrary(String storyId, bool inLibrary) async {
    final readings = await getUserReadings(null);
    if (readings.isEmpty) {
      return false;
    }

    final readingToUpdate = readings.firstWhere(
      (reading) => reading.storyId == storyId,
      orElse: () => throw Exception('Reading not found'),
    );

    final updatedReading =
        Reading(storyId: readingToUpdate.storyId, inLibrary: inLibrary);

    final readingIndex = readings.indexOf(readingToUpdate);
    readings[readingIndex] = updatedReading;

    final readingMaps = readings.map((r) => r.toFirestore()).toList();

    final appUserDoc = await db
        .collection(APP_USER_COLLECTION_REF)
        .where('authUserUid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();

    await appUserDoc.docs.first.reference.update({
      "readings": readingMaps,
    });

    return true;
  }

  @override
  Future<bool> unlockNewReadingChapter(
      String storyId, String chapterUid) async {
    final readings = await getUserReadings(null);
    if (readings.isEmpty) {
      return false;
    }
    final readingToUpdate = readings.firstWhere(
      (reading) => reading.storyId == storyId,
      orElse: () => throw Exception('User is not reading this story'),
    );
    if (readingToUpdate.readingChaptersUids?.contains(chapterUid) ?? false) {
      throw Exception('Chapter is already unlocked');
    }

    final updatedReading = Reading(
      storyId: readingToUpdate.storyId,
      readingChaptersUids: [
        ...(readingToUpdate.readingChaptersUids ?? []),
        chapterUid
      ],
    );
    final readingIndex = readings.indexOf(readingToUpdate);
    readings[readingIndex] = updatedReading;
    final readingMaps = readings.map((r) => r.toFirestore()).toList();

    final appUserDoc = await db
        .collection(APP_USER_COLLECTION_REF)
        .where('authUserUid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (appUserDoc.docs.isEmpty) {
      return false;
    }
    await appUserDoc.docs.first.reference.update({
      "readings": readingMaps,
    });
    return true;
  }
}
