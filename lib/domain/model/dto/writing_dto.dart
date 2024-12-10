import 'package:h3_14_bookie/domain/model/dto/chapter_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/story_response_dto.dart';

class WritingDto {
  final StoryResponseDto story;
  final List<ChapterDto> chapters;
  final bool isDraft;

  WritingDto(this.story, this.chapters, this.isDraft);
}
