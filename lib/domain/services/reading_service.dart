import 'package:h3_14_bookie/domain/model/reading.dart';

interface class IReadingService {
  Future<List<Reading>> getUserReadings(bool inLibrary) async {
    throw UnimplementedError();
  }

  Future<Map<String, int>> getLastPageInReadedChaptersByStoryId(
      String storyId) async {
    throw UnimplementedError();
  }

  Future<int> getLastPageNumberInReadedChapter(
      String storyId, String chapterUid) async {
    throw UnimplementedError();
  }

  Future<bool> addNewReading(String storyId, bool inLibrary) async {
    throw UnimplementedError();
  }

  Future<bool> saveLastPageInChapterReaded(
      String storyId, String chapterUid, int lastPageReaded) async {
    throw UnimplementedError();
  }

  Future<bool> updateInLibrary(String storyId, bool inLibrary) async {
    throw UnimplementedError();
  }

  Future<bool> unlockNewReadingChapter(
      String storyId, String chapterUid) async {
    throw UnimplementedError();
  }
}
