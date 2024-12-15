import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h3_14_bookie/domain/model/dto/category_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/story_response_dto.dart';
import 'package:h3_14_bookie/domain/model/story.dart';
import 'package:h3_14_bookie/domain/services/story_service.dart';

part 'home_view_event.dart';
part 'home_view_state.dart';

class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState> {
  final IStoryService storyService;
  HomeViewBloc({
    required this.storyService
  }) : super(const HomeViewState()) {
    on<GetStoriesHome>(_onGetStories);
    // on<GetInfoStory>(_onGetInfoStory);
  }

  void _onGetStories(GetStoriesHome event, Emitter<HomeViewState> emit) async {
    try{
      emit(state.copyWith(
        isLoading: true,
      ));
      final list = await storyService.getStoriesWithFilter(event.filter, event.category);
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

  // void _onGetInfoStory(GetInfoStory event, Emitter<HomeViewState> emit) async {
  //   try{
  //     emit(state.copyWith(
  //       isLoading: true,
  //     ));
  //     final list = await storyService.getStoryById(event.storyUid);
  //     emit(state.copyWith(
  //       isLoading: false
  //     ));
  //   }
  //   catch(e) {
  //     Fluttertoast.showToast(msg: '$e');
  //     emit(state.copyWith(
  //       isLoading: false
  //     ));
  //   }
  // }
}
