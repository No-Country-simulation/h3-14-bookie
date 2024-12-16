class ChapterDto {
  final String storyUid;
  final String? chapterUid;
  final String title;
  final List<String> pages;
  final String placeName;
  final double lat;
  final double long;

  const ChapterDto({
    required this.storyUid,
    this.chapterUid,
    required this.title,
    required this.pages,
    required this.placeName,
    required this.lat,
    required this.long,
  });
}
