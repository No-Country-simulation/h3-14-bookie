class ChapterDto {
  final String storyUid;
  final String title;
  final List<String> pages;
  final String placeName;
  final double lat;
  final double long;

  ChapterDto({
    required this.storyUid,
    required this.title,
    required this.pages,
    required this.placeName,
    required this.lat,
    required this.long,
  });
}
