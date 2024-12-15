part of 'read_view_bloc.dart';

sealed class ReadViewEvent extends Equatable {
  const ReadViewEvent();

  @override
  List<Object> get props => [];
}

class ChangeChapters extends ReadViewEvent{
  final List<Chapter> chapters;
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
  final String uid;
  const ChangeStoryUidSelected({
    required this.uid
  });
}
