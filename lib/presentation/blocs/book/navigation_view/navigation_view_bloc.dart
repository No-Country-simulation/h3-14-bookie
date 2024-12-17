import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h3_14_bookie/domain/model/dto/chapter_story_response_dto.dart';
import 'package:h3_14_bookie/domain/services/chapter_service.dart';
import 'package:h3_14_bookie/domain/services/story_service.dart';

part 'navigation_view_event.dart';
part 'navigation_view_state.dart';

class NavigationViewBloc
    extends Bloc<NavigationViewEvent, NavigationViewState> {
  final IStoryService storyService;
  NavigationViewBloc({required this.storyService})
      : super(const NavigationViewState()) {
    on<GetStoryChapterEvent>(_onGetStoryChapterEvent);
  }

  void _onGetStoryChapterEvent(
      GetStoryChapterEvent event, Emitter<NavigationViewState> emit) async {
    try {
      emit(state.copyWith(
        loading: true,
      ));
      final list = await storyService.getAllFirstChaptersStory();
      emit(state.copyWith(
        listChapterStory: list,
        loading: false,
      ));
    } catch (e) {
      Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
    }
  }
}
