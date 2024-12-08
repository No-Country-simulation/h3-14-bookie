part of 'book_create_bloc.dart';

sealed class BookCreateEvent extends Equatable {
  const BookCreateEvent();

  @override
  List<Object> get props => [];
}

class AddTargetEvent extends BookCreateEvent{
  final String target;
  const AddTargetEvent({
    required this.target
  });
  @override
  List<Object> get props => [target];
}

class InitCategoriesEvent extends BookCreateEvent{
  const InitCategoriesEvent();
}

class ToogleCategoryEvent extends BookCreateEvent{
  final String uidCategory;
  const ToogleCategoryEvent({
    required this.uidCategory
  });
}

class AddInitialChapterEvent extends BookCreateEvent{
  final String title;
  final String placeName;
  const AddInitialChapterEvent({
    required this.title,
    required this.placeName
  });
}

class UpdateChapterActive extends BookCreateEvent{
  final BookChapterEntity chapter;
  final Function? whenComplete;
  const UpdateChapterActive({
    required this.chapter,
    this.whenComplete
  });
}

class SaveChapterActive extends BookCreateEvent{
  final BookChapterEntity chapter;
  const SaveChapterActive({
    required this.chapter
  });
}

class UpdateCurrentPage extends BookCreateEvent{
  final int page;
  const UpdateCurrentPage({
    required this.page
  });
}

class AddChapterEvent extends BookCreateEvent{
  const AddChapterEvent();
}

class CreateStoryEvent extends BookCreateEvent{
  final StoryDto story;
  const CreateStoryEvent({
    required this.story
  });
}
