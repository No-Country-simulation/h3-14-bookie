class StoryResponseDto {
  final String storyUid;
  final String title;
  final String authorName;
  final String cover;
  final String synopsis;
  final List<String> labels;
  final List<String> categories;
  final int rate;
  final int readings;
  final int storyTimeInMin;
  final List<String> chaptersUid;

  StoryResponseDto(
      this.storyUid,
      this.title,
      this.authorName,
      this.cover,
      this.synopsis,
      this.labels,
      this.categories,
      this.rate,
      this.readings,
      this.storyTimeInMin,
      this.chaptersUid);
}
