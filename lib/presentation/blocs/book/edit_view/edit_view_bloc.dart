import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h3_14_bookie/config/helpers/enums/book_enum.dart';
import 'package:h3_14_bookie/domain/model/dto/writing_dto.dart';
import 'package:h3_14_bookie/domain/services/writing_service.dart';

part 'edit_view_event.dart';
part 'edit_view_state.dart';

class EditViewBloc extends Bloc<EditViewEvent, EditViewState> {
  final IWritingService writingService;
  EditViewBloc({
    required this.writingService,
  }) : super(const EditViewState()) {
    on<GetStories>(_onGetStories);
    on<ChangeFilter>(_onChangeFilter);
  }

  void _onGetStories(GetStories event, Emitter<EditViewState> emit) async {
    try{
      emit(state.copyWith(
        isLoading: true,
      ));
      final list = await writingService.getMyWritings(event.draftOrPublish);
      emit(state.copyWith(
        stories: list,
        isLoading: false
      ));
    }
    catch(e) {
      Fluttertoast.showToast(msg: '$e');
      emit(state.copyWith(
        isLoading: false
      ));
    }
  }

  void _onChangeFilter(ChangeFilter event, Emitter<EditViewState> emit) async {
    add(GetStories(
      draftOrPublish: event.filter == FilterBook.all
        ? null
        : event.filter == FilterBook.drafts
          ? 'draft'
          : 'publish'
    ));
    emit(state.copyWith(
      filterSelected: event.filter
    ));
  }
}
