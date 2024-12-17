import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h3_14_bookie/config/helpers/enums/book_enum.dart';
import 'package:h3_14_bookie/domain/model/dto/writing_dto.dart';
import 'package:h3_14_bookie/domain/model/writing.dart';
import 'package:h3_14_bookie/domain/services/app_user_service.dart';
import 'package:h3_14_bookie/domain/services/story_service.dart';
import 'package:h3_14_bookie/domain/services/writing_service.dart';

part 'edit_view_event.dart';
part 'edit_view_state.dart';

class EditViewBloc extends Bloc<EditViewEvent, EditViewState> {
  final IWritingService writingService;
  final IAppUserService appUserService;
  final IStoryService storyService;
  EditViewBloc({
    required this.writingService,
    required this.appUserService,
    required this.storyService,
  }) : super(const EditViewState()) {
    on<GetStories>(_onGetStories);
    on<ChangeFilter>(_onChangeFilter);
    on<ChangeStatusBook>(_onChangeStatusBook);
    on<DeleteCreateBook>(_onDeleteCreateBook);
  }

  void _onGetStories(GetStories event, Emitter<EditViewState> emit) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));
      final list = await writingService.getMyWritings(event.draftOrPublish);
      emit(state.copyWith(stories: list, isLoading: false));
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onChangeFilter(ChangeFilter event, Emitter<EditViewState> emit) async {
    add(GetStories(
        draftOrPublish: event.filter == FilterBook.all
            ? null
            : event.filter == FilterBook.drafts
                ? 'draft'
                : 'publish'));
    emit(state.copyWith(filterSelected: event.filter));
  }

  void _onChangeStatusBook(
      ChangeStatusBook event, Emitter<EditViewState> emit) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));
      await appUserService.updateUserWriting(event.writing);
      Future.delayed(const Duration(milliseconds: 1000));
      add(GetStories(
          draftOrPublish: state.filterSelected == FilterBook.all
              ? null
              : state.filterSelected == FilterBook.drafts
                  ? 'draft'
                  : 'publish'));
      if(event.whenComplete != null){
        event.whenComplete!();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  void _onDeleteCreateBook(
      DeleteCreateBook event, Emitter<EditViewState> emit) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));
      await storyService.deleteStory(event.id);
      add(GetStories(
          draftOrPublish: state.filterSelected == FilterBook.all
              ? null
              : state.filterSelected == FilterBook.drafts
                  ? 'draft'
                  : 'publish'));
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }
}
