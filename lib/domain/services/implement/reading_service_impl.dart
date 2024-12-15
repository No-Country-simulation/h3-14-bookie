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
import 'package:h3_14_bookie/constants/collection_references.dart';

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

  /// Returns the last page number readed in the mapped chapters of the story
  /// If the story is not readed, throws an exception
  @override
  Future<Map<String, int>> getLastPageInReadedChaptersByStoryId(
      String storyId) async {
    final readings = await getUserReadings(null);
    final reading = readings.firstWhere(
      (reading) => reading.storyId == storyId,
      orElse: () => throw Exception('User is not reading this story'),
    );
    return reading.lastPageInChapterReaded ?? {};
  }

  /// Returns the last page number readed in the chapter
  /// If the chapter is not readed, throws an exception
  @override
  Future<int> getLastPageNumberInReadedChapter(
      String storyId, String chapterUid) async {
    final lastPageInChaptersReaded =
        await getLastPageInReadedChaptersByStoryId(storyId);
    final lastPageInChapterReaded = lastPageInChaptersReaded[chapterUid];
    if (lastPageInChapterReaded == null) {
      throw Exception('Chapter not found');
    }
    return lastPageInChapterReaded;
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
        readingChaptersUids: [firstChapterUid],
        lastPageInChapterReaded: {firstChapterUid: 1});
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
        .collection(CollectionReferences.APP_USER_COLLECTION_REF)
        .where('authUserUid', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();

    await appUserDoc.docs.first.reference.update({
      "readings": readingMaps,
    });

    return true;
  }

  /// Saves the last page readed in the chapter
  /// If the chapter is not readed, throws an exception
  /// If the page number is out of bounds, throws an exception
  @override
  Future<bool> saveLastPageInChapterReaded(
      String storyId, String chapterUid, int lastPageReaded) async {
    final readings = await getUserReadings(null);
    if (readings.isEmpty) {
      return false;
    }
    final readingToUpdate = readings.firstWhere(
      (reading) => reading.storyId == storyId,
      orElse: () => throw Exception('User is not reading this story'),
    );

    try {
      await chapterService.getChapterPage(chapterUid, lastPageReaded);
    } catch (e) {
      throw Exception('Page not found');
    }

    final updatedReading = Reading(
      storyId: readingToUpdate.storyId,
      readingChaptersUids: readingToUpdate.readingChaptersUids,
      lastPageInChapterReaded: {
        ...(readingToUpdate.lastPageInChapterReaded ?? {}),
        chapterUid: lastPageReaded
      },
    );

    final readingIndex = readings.indexOf(readingToUpdate);
    readings[readingIndex] = updatedReading;

    String authUserUid = FirebaseAuth.instance.currentUser?.uid ?? "";

    if (authUserUid == "") {
      throw Exception('User not logged in');
    }

    appUserService
        .updateAppUser(AppUser(authUserUid: authUserUid, readings: readings));

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
        .collection(CollectionReferences.APP_USER_COLLECTION_REF)
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
