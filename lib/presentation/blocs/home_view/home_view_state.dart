part of 'home_view_bloc.dart';

class HomeViewState extends Equatable {
  final List<BookNearEntity> stories;
  final bool isLoading;
  const HomeViewState({
    this.stories = const [],
    this.isLoading = false,  
  });
  
  @override
  List<Object> get props => [
    stories,
    isLoading,
  ];

  HomeViewState copyWith({
    List<BookNearEntity>? stories,
    bool? isLoading,
  }) {
    return HomeViewState(
      stories: stories ?? this.stories,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
