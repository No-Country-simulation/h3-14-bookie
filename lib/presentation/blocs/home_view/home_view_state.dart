part of 'home_view_bloc.dart';

sealed class HomeViewState extends Equatable {
  const HomeViewState();
  
  @override
  List<Object> get props => [];
}

final class HomeViewInitial extends HomeViewState {}
