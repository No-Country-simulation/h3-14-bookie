import 'package:h3_14_bookie/domain/model/chapter.dart';
import 'package:h3_14_bookie/domain/model/dto/chapter_dto.dart';

interface class IChapterService {
  Future<List<Chapter>> getChapters() async {
    return [];
  }

  Future<Chapter> getChapterById(String chapterUid) async {
    throw UnimplementedError();
  }

  Future<ChapterDto> convertToChapterDto(Chapter chapter) async {
    throw UnimplementedError();
  }

  Future<String> createChapter(ChapterDto chapterDto) async {
    return Future.value('');
  }
}
