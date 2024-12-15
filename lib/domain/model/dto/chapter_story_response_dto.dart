class ChapterStoryResponseDto {
  final String chapterUid;
  final String storyUid;
  final String title;
  final String cover;
  final String synopsis;
  final List<String> categories;
  final double rate;
  final int totalReadings;
  final bool isReading;
  final int chapterNumber;
  final String chapterTitle;
  final String placeName;
  final double latitude;
  final double longitude;

  ChapterStoryResponseDto({
    required this.chapterUid,
    required this.storyUid,
    required this.title,
    required this.cover,
    required this.synopsis,
    required this.categories,
    required this.rate,
    required this.totalReadings,
    required this.isReading,
    required this.chapterNumber,
    required this.chapterTitle,
    required this.placeName,
    required this.latitude,
    required this.longitude,
  });
}
