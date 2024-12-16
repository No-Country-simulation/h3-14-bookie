part of 'favorite_view_bloc.dart';

class FavoriteViewState extends Equatable {
  final List<BookFavoriteEntity> listFavorites;
  final bool loading;
  const FavoriteViewState({
    this.listFavorites = const [],
    this.loading = false,
  });

  FavoriteViewState copyWith({
    List<BookFavoriteEntity>? listFavorites,
    bool? loading,
  }) {
    return FavoriteViewState(
      listFavorites: listFavorites ?? this.listFavorites,
      loading: loading ?? this.loading,
    );
  }
  
  @override
  List<Object> get props => [listFavorites, loading];
}
