part of 'favorite_view_bloc.dart';

class FavoriteViewState extends Equatable {
  final List<BookFavoriteEntity> listFavorites;
  final bool loadingFavorites;
  const FavoriteViewState({
    this.listFavorites = const [],
    this.loadingFavorites = false,
  });

  FavoriteViewState copyWith({
    List<BookFavoriteEntity>? listFavorites,
    bool? loadingFavorites,
  }) {
    return FavoriteViewState(
      listFavorites: listFavorites ?? this.listFavorites,
      loadingFavorites: loadingFavorites ?? this.loadingFavorites,
    );
  }
  
  @override
  List<Object> get props => [listFavorites, loadingFavorites];
}
