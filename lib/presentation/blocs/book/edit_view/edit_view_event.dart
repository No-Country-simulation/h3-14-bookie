part of 'edit_view_bloc.dart';

sealed class EditViewEvent extends Equatable {
  const EditViewEvent();

  @override
  List<Object> get props => [];
}

class GetStories extends EditViewEvent {
  final String? draftOrPublish;
  const GetStories({
    this.draftOrPublish,
  });
}

class ChangeFilter extends EditViewEvent {
  final FilterBook filter;
  const ChangeFilter({
    required this.filter
  });
}

class ChangeStatusBook extends EditViewEvent {
  final Writing writing;
  final Function? whenComplete;
  const ChangeStatusBook({
    required this.writing,
    this.whenComplete
  });
}

class DeleteCreateBook extends EditViewEvent {
  final String id;
  const DeleteCreateBook({
    required this.id
  });
}
