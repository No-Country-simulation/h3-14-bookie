class StoryDto {
  String title;
  String? cover;
  String? synopsis;
  List<String> categoriesUid;
  List<String>? labels;

  StoryDto(
      {required this.title,
      this.cover,
      this.synopsis,
      required this.categoriesUid,
      this.labels});
}
