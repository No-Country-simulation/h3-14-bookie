part of 'edit_view_bloc.dart';

class EditViewState extends Equatable {
  final List<WritingDto> stories;
  final FilterBook filterSelected;
  final bool isLoading;
  const EditViewState({
    this.stories = const [],
    this.filterSelected = FilterBook.all,
    this.isLoading = false,
  });
  
  @override
  List<Object> get props => [
    stories,
    filterSelected,
    isLoading,
  ];
  
  EditViewState copyWith({
    List<WritingDto>? stories,
    FilterBook? filterSelected,
    bool? isLoading,
  }) {
    return EditViewState(
      stories: stories ?? this.stories,
      filterSelected: filterSelected ?? this.filterSelected,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

