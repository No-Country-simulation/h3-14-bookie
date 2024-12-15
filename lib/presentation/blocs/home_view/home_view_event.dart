part of 'home_view_bloc.dart';

sealed class HomeViewEvent extends Equatable {
  const HomeViewEvent();

  @override
  List<Object> get props => [];
}

class GetStoriesHome extends HomeViewEvent {
  final String filter;
  final CategoryDto? category;
  
  const GetStoriesHome({
    required this.filter,
    this.category,
  });
}

class GetInfoStory extends HomeViewEvent {
  final String storyUid;
  const GetInfoStory({
    required this.storyUid
  });
}