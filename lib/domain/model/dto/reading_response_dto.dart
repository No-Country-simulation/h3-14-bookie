class ReadingResponseDto {
  final String storyId;
  final List<String>? readingChaptersUids;
  final bool? inLibrary;
  final Map<String, int>? lastPageInChapterReaded;
  final String? cover;
  final String? title;
  final String? synopsis;
  final double? rate;
  final int? totalReadings;

  ReadingResponseDto(
      this.storyId,
      this.inLibrary,
      this.cover,
      this.title,
      this.synopsis,
      this.rate,
      this.totalReadings,
      this.readingChaptersUids,
      this.lastPageInChapterReaded);
}
