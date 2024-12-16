part of 'read_view_bloc.dart';

sealed class ReadViewEvent extends Equatable {
  const ReadViewEvent();

  @override
  List<Object> get props => [];
}

class ChangeChapters extends ReadViewEvent{
  final List<ChapterDto> chapters;
  const ChangeChapters({
    required this.chapters
  });
}

class ChangePageChapterSelected extends ReadViewEvent{
  final int page;
  const ChangePageChapterSelected({
    required this.page
  });
}

class ChangeStoryUidSelected extends ReadViewEvent{
  final HomeStoryDto story;
  const ChangeStoryUidSelected({
    required this.story
  });
}

class ChangeChapterReadActive extends ReadViewEvent {
  final String storyId;
  const ChangeChapterReadActive({
    required this.storyId
  });
}
