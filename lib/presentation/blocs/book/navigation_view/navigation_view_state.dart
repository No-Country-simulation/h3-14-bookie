part of 'navigation_view_bloc.dart';

class NavigationViewState extends Equatable {
  final List<ChapterStoryResponseDto> listChapterStory;
  final bool loading;
  const NavigationViewState({
    this.listChapterStory = const [],
    this.loading = false,
  });
  
  NavigationViewState copyWith({
    List<ChapterStoryResponseDto>? listChapterStory,
    bool? loading
  }) {
    return NavigationViewState(
      listChapterStory: listChapterStory ?? this.listChapterStory,
      loading: loading ?? this.loading,
    );
  }
  @override
  List<Object> get props => [listChapterStory, loading];
}
