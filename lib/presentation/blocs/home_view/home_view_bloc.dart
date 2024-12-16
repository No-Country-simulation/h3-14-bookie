import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h3_14_bookie/domain/entities/book_near_entity.dart';
import 'package:h3_14_bookie/domain/entities/category_user_entity.dart';
import 'package:h3_14_bookie/domain/model/dto/category_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/story_response_dto.dart';
import 'package:h3_14_bookie/domain/model/story.dart';
import 'package:h3_14_bookie/domain/services/category_service.dart';
import 'package:h3_14_bookie/domain/services/reading_service.dart';
import 'package:h3_14_bookie/domain/services/story_service.dart';

part 'home_view_event.dart';
part 'home_view_state.dart';

class HomeViewBloc extends Bloc<HomeViewEvent, HomeViewState> {
  final IStoryService storyService;
  final IReadingService readingService;
  final ICategoryService categoryService;
  HomeViewBloc({
    required this.storyService,
    required this.readingService,
    required this.categoryService,
  }) : super(const HomeViewState()) {
    on<InitHomeEvent>(_onInitHomeEvent);
    on<GetStoriesHome>(_onGetStories);
    // on<GetInfoStory>(_onGetInfoStory);
    on<ChangeFavoriteStoryHome>(_onChangeFavoriteStoryHome);
  }

  void _onInitHomeEvent(InitHomeEvent event, Emitter<HomeViewState> emit) async {
    final categories = await categoryService.getCategories();
    add(const GetStoriesHome(filter: ''));
    emit(state.copyWith(
      categories: categories.map((c)=>CategoryUserEntity(name: c.name, isActive: false, uid: c.uid)).toList(),
    ));
  }

  void _onGetStories(GetStoriesHome event, Emitter<HomeViewState> emit) async {
    try{
      emit(state.copyWith(
        isLoading: true,
      ));
      final list = await storyService.getStoriesWithFilter(event.filter, event.category);
      final newList = list.map((s) => BookNearEntity(story: s, isFavorite: s.inLibrary ?? false)).toList();
      emit(state.copyWith(
        stories: newList,
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

  void _onChangeFavoriteStoryHome(ChangeFavoriteStoryHome event, Emitter<HomeViewState> emit) {
    try {
      List<BookNearEntity> list = List.from(state.stories);
      readingService.addNewReading(list[event.index].story.storyUid, true);
      list[event.index] = BookNearEntity(story: list[event.index].story, isFavorite: !list[event.index].isFavorite);
      // int index = list.indexWhere((c) => c.number == event.number);
      // if(index == -1){return;}
      emit(state.copyWith(
        stories: list
      ));
    } catch (e) {
      Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
    }

  }
}
