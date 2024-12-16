part of 'favorite_view_bloc.dart';

sealed class FavoriteViewEvent extends Equatable {
  const FavoriteViewEvent();

  @override
  List<Object> get props => [];
}

class InitFavoritesEvent extends FavoriteViewEvent {
  const InitFavoritesEvent();
}

class GetListFavorites extends FavoriteViewEvent {
  const GetListFavorites();
}

class ChangeFavoriteStoryFavorites extends FavoriteViewEvent {
  final int index;
  const ChangeFavoriteStoryFavorites({
    required this.index
  });
}
