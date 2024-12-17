part of 'read_view_bloc.dart';

class ReadViewState extends Equatable {
  final HomeStoryDto story;
  final int pageChapterSelected;
  final List<ChapterDto> chapterList;
  final ChapterDto chapterActive;
  const ReadViewState({
    this.story = const HomeStoryDto(
        authorName: '',
        storyUid: '',
        title: '',
        cover: '',
        synopsis: '',
        labels: [],
        categoryNames: [],
        rate: 0,
        totalReadings: 0,
        chapters: []
    ),
    this.pageChapterSelected = 0,
    this.chapterList = const [],
    this.chapterActive = const ChapterDto(lat: 0,long: 0,pages: [], storyUid: '', title: '', placeName: '',)
  });
  
  @override
  List<Object> get props => [chapterList, story, pageChapterSelected];

  ReadViewState copyWith({
    HomeStoryDto? story,
    int? pageChapterSelected,
    List<ChapterDto>? chapterList,
    ChapterDto? chapterActive,
  }) {
    return ReadViewState(
      story: story ?? this.story,
      pageChapterSelected: pageChapterSelected ?? this.pageChapterSelected,
      chapterList: chapterList ?? this.chapterList,
      chapterActive: chapterActive ?? this.chapterActive
    );
  }
}
