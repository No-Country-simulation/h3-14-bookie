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
  final Function? whenComplete;
  const CreateStoryEvent({
    this.whenComplete,
  });
}

class SaveStoryEvent extends BookCreateEvent{
  final String titleBook;
  final String titleChapter;
  final String placeName;
  final String synopsisBook;
  final String pathImage;
  const SaveStoryEvent({
    required this.titleBook,
    required this.synopsisBook,
    required this.pathImage,
    required this.titleChapter,
    required this.placeName,
  });
}

class CreateChapterEvent extends BookCreateEvent{
  const CreateChapterEvent();
}

class ResetValuesBookCreateEvent extends BookCreateEvent{
  const ResetValuesBookCreateEvent();
}

class ChangeChapterActive extends BookCreateEvent {
  final int number;
  const ChangeChapterActive({
    required this.number
  });
}

class DeleteChapterEvent extends BookCreateEvent {
  final int number;
  const DeleteChapterEvent({
    required this.number
  });
}

class DeleteTargetEvent extends BookCreateEvent {
  final int index;
  const DeleteTargetEvent({
    required this.index
  });
}
