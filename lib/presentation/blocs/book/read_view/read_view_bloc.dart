import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:h3_14_bookie/domain/model/chapter.dart';

part 'read_view_event.dart';
part 'read_view_state.dart';

class ReadViewBloc extends Bloc<ReadViewEvent, ReadViewState> {
  ReadViewBloc() : super(const ReadViewState()) {
    on<ChangeChapters>(_onChangeChapters);
    on<ChangePageChapterSelected>(_onChangePageChapterSelected);
    on<ChangeStoryUidSelected>(_onChangeStoryUidSelected);
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
    emit(state.copyWith(
      storyId: event.uid
    ));
  }
}
