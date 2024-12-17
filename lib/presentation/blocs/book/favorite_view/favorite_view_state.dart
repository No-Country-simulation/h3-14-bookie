part of 'favorite_view_bloc.dart';

class FavoriteViewState extends Equatable {
  final List<BookFavoriteEntity> listFavorites;
  final bool loadingFavorites;
  final List<ReadingResponseDto> list;
  final bool loading;
  const FavoriteViewState({
    this.listFavorites = const [],
    this.loadingFavorites = false,
    this.list = const [],
    this.loading = false,
  });

  FavoriteViewState copyWith({
    List<BookFavoriteEntity>? listFavorites,
    bool? loadingFavorites,
    List<ReadingResponseDto>? list,
    bool? loading,
  }) {
    return FavoriteViewState(
      listFavorites: listFavorites ?? this.listFavorites,
      loadingFavorites: loadingFavorites ?? this.loadingFavorites,
      list: list ?? this.list,
      loading: loading ?? this.loading,
    );
  }
  
  @override
  List<Object> get props => [listFavorites, loadingFavorites, list, loading];
}
