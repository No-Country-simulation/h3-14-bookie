import 'package:h3_14_bookie/domain/model/chapter.dart';
import 'package:h3_14_bookie/domain/model/dto/chapter_dto.dart';

interface class IChapterService {
  Future<List<Chapter>> getChapters() async {
    return [];
  }

  Future<Chapter> getChapterById(String chapterUid) async {
    throw UnimplementedError();
  }

  Future<String> getChapterUidByStoryUidAndChapterNumber(
      String storyUid, int chapterNumber) async {
    throw UnimplementedError();
  }

  Future<List<Chapter>> getChaptersByStoryUid(String storyUid) async {
    return [];
  }

  Future<Chapter> getFirstChapterByStoryUid(String storyUid) async {
    throw UnimplementedError();
  }

  Future<List<String>> getChapterPages(String chapterUid) async {
    throw UnimplementedError();
  }

  Future<String> getChapterPage(String chapterUid, int pageNumber) async {
    throw UnimplementedError();
  }

  Future<ChapterDto> convertToChapterDto(Chapter chapter) async {
    throw UnimplementedError();
  }

  Future<String> createChapter(ChapterDto chapterDto, int chapterNumber) async {
    return Future.value('');
  }

  Future<bool> deleteChaptersByStoryUid(String storyUid) async {
    return Future.value(false);
  }

  Future<bool> deleteChapter(String chapterUid) async {
    throw UnimplementedError();
  }
}
