import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h3_14_bookie/domain/entities/book_favorite_entity.dart';
import 'package:h3_14_bookie/domain/model/dto/reading_response_dto.dart';
import 'package:h3_14_bookie/domain/services/reading_service.dart';

part 'favorite_view_event.dart';
part 'favorite_view_state.dart';

class FavoriteViewBloc extends Bloc<FavoriteViewEvent, FavoriteViewState> {
  final IReadingService readingService;
  FavoriteViewBloc({
    required this.readingService
  }) : super(const FavoriteViewState()) {
    on<GetListFavorites>(_onGetListFavorites);
    on<InitFavoritesEvent>(_onInitFavoritesEvent);
    on<ChangeFavoriteStoryFavorites>(_onChangeFavoriteStoryFavorites);
    on<GetReadingStoryEvent>(_onGetReadingStoryEvent);
  }

  void _onInitFavoritesEvent(InitFavoritesEvent event, Emitter<FavoriteViewState> emit) async {
    try {
      emit(state.copyWith(loading: true, loadingFavorites: true));
      
      add(const GetListFavorites());
      add(const GetReadingStoryEvent());
      
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  void _onGetListFavorites(GetListFavorites event, Emitter<FavoriteViewState> emit) async {
    try {
      emit(state.copyWith(
        loadingFavorites: true,
      ));
      final list = await readingService.getUserReadingsResponseDto(true);
      final newList = list.map((r) => BookFavoriteEntity(reading: r, isFavorite: true)).toList();
      emit(state.copyWith(
        listFavorites: newList,
        loadingFavorites: false,
      ));
    } catch (e) {
      Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
    }
  }

  void _onGetReadingStoryEvent(GetReadingStoryEvent event, Emitter<FavoriteViewState> emit) async {
    try {
      emit(state.copyWith(
        loading: true,
      ));
      final list = await readingService.getUserReadingsResponseDto(null);
      List<ReadingResponseDto> newList = List.from(list);
      // final newList = list.map((r) => BookFavoriteEntity(reading: r, isFavorite: r.inLibrary ?? false)).toList();
      emit(state.copyWith(
        list: newList,
        loading: false,
      ));
    } catch (e) {
      Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
    }
  }

  void _onChangeFavoriteStoryFavorites(ChangeFavoriteStoryFavorites event, Emitter<FavoriteViewState> emit) async {
    try {
      List<BookFavoriteEntity> list = List.from(state.listFavorites);
      await readingService.updateInLibrary(list[event.index].reading.storyId!, !list[event.index].isFavorite);
      list[event.index] = BookFavoriteEntity(reading: list[event.index].reading, isFavorite: !list[event.index].isFavorite);
      // int index = list.indexWhere((c) => c.number == event.number);
      // if(index == -1){return;}
      emit(state.copyWith(
        listFavorites: list
      ));
      await Future.delayed(const Duration(milliseconds: 500));
      add(const GetListFavorites());
    } catch (e) {
      Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
    }
  }
}
