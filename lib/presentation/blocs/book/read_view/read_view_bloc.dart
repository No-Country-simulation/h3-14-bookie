import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h3_14_bookie/domain/model/dto/chapter_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/home_story_dto.dart';

part 'read_view_event.dart';
part 'read_view_state.dart';

class ReadViewBloc extends Bloc<ReadViewEvent, ReadViewState> {
  ReadViewBloc() : super(const ReadViewState()) {
    on<ChangeChapters>(_onChangeChapters);
    on<ChangePageChapterSelected>(_onChangePageChapterSelected);
    on<ChangeStoryUidSelected>(_onChangeStoryUidSelected);
    on<ChangeChapterReadActive>(_onChangeChapterReadActive);
  }

  void _onChangeChapters(ChangeChapters event, Emitter<ReadViewState> emit) {
    emit(state.copyWith(
      chapterList: event.chapters
    ));
  }

  void _onChangePageChapterSelected(ChangePageChapterSelected event, Emitter<ReadViewState> emit) {
    emit(state.copyWith(
      pageChapterSelected: event.page
    ));
  }

  void _onChangeStoryUidSelected(ChangeStoryUidSelected event, Emitter<ReadViewState> emit) {
    final chapters = event.story.chapters;
    emit(state.copyWith(
      story: event.story,
      chapterActive: chapters.first,
      chapterList: chapters,
    ));
  }

  void _onChangeChapterReadActive(ChangeChapterReadActive event, Emitter<ReadViewState> emit) {
    int index = state.chapterList.indexWhere((c) => c.storyUid == event.storyId);
    emit(state.copyWith(
      chapterActive: state.chapterList[index],
    ));
  }
}
