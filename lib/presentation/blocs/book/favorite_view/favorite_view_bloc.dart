import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h3_14_bookie/domain/entities/book_favorite_entity.dart';
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
  }

  void _onInitFavoritesEvent(InitFavoritesEvent event, Emitter<FavoriteViewState> emit) {
    add(const GetListFavorites());
  }

  void _onGetListFavorites(GetListFavorites event, Emitter<FavoriteViewState> emit) async {
    try {
      emit(state.copyWith(
        loading: true,
      ));
      final list = await readingService.getUserReadingsResponseDto(true);
      final newList = list.map((r) => BookFavoriteEntity(reading: r, isFavorite: true)).toList();
      emit(state.copyWith(
        listFavorites: newList,
        loading: false,
      ));
    } catch (e) {
      Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
    }
  }

  void _onChangeFavoriteStoryFavorites(ChangeFavoriteStoryFavorites event, Emitter<FavoriteViewState> emit) async {
    try {
      List<BookFavoriteEntity> list = List.from(state.listFavorites);
      readingService.updateInLibrary(list[event.index].reading.storyId!, !list[event.index].isFavorite);
      list[event.index] = BookFavoriteEntity(reading: list[event.index].reading, isFavorite: !list[event.index].isFavorite);
      // int index = list.indexWhere((c) => c.number == event.number);
      // if(index == -1){return;}
      emit(state.copyWith(
        listFavorites: list
      ));
      add(const GetListFavorites());
    } catch (e) {
      Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
    }
  }
}
