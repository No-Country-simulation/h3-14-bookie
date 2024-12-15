part of 'navigation_view_bloc.dart';

sealed class NavigationViewEvent extends Equatable {
  const NavigationViewEvent();

  @override
  List<Object> get props => [];
}

class GetStoryChapterEvent extends NavigationViewEvent {
  const GetStoryChapterEvent();
}
