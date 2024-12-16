part of 'home_view_bloc.dart';

class HomeViewState extends Equatable {
  final List<BookNearEntity> stories;
  final List<CategoryUserEntity> categories;
  final bool isLoading;
  const HomeViewState({
    this.stories = const [],
    this.categories = const [],
    this.isLoading = false,  
  });
  
  @override
  List<Object> get props => [
    stories,
    isLoading,
  ];

  HomeViewState copyWith({
    List<BookNearEntity>? stories,
    List<CategoryUserEntity>? categories,
    bool? isLoading,
  }) {
    return HomeViewState(
      stories: stories ?? this.stories,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
