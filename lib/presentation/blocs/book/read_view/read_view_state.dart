part of 'read_view_bloc.dart';

class ReadViewState extends Equatable {
  final String storyId;
  final int pageChapterSelected;
  final List<Chapter> chapterList;
  const ReadViewState({
    this.storyId = '',
    this.pageChapterSelected = 1,
    this.chapterList = const []
  });
  
  @override
  List<Object> get props => [chapterList, storyId, pageChapterSelected];

  ReadViewState copyWith({
    String? storyId,
    int? pageChapterSelected,
    List<Chapter>? chapterList,
  }) {
    return ReadViewState(
      storyId: storyId ?? this.storyId,
      pageChapterSelected: pageChapterSelected ?? this.pageChapterSelected,
      chapterList: chapterList ?? this.chapterList,
    );
  }
}
