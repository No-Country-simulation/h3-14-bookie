import 'package:h3_14_bookie/domain/model/dto/chapter_dto.dart';

class HomeStoryDto {
  final String storyUid;
  final String title;
  final String authorName;
  final String cover;
  final String synopsis;
  final List<String> labels;
  final List<String> categoryNames;
  final double rate;
  final int totalReadings;
  final List<ChapterDto> chapters;

  const HomeStoryDto({
    required this.storyUid,
    required this.title,
    required this.authorName,
    required this.cover,
    required this.synopsis,
    required this.labels,
    required this.categoryNames,
    required this.rate,
    required this.totalReadings,
    required this.chapters,
  });
}
