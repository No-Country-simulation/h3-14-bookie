part of 'home_view_bloc.dart';

class HomeViewState extends Equatable {
  final List<StoryResponseDto> stories;
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
    List<StoryResponseDto>? stories,
    bool? isLoading,
  }) {
    return HomeViewState(
      stories: stories ?? this.stories,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
