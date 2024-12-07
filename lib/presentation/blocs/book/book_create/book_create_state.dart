part of 'book_create_bloc.dart';

class BookCreateState extends Equatable {
  final List<String> targets;
  final List<CategoryUserEntity> categories;
  final int selectedIndexChapter;
  final List<BookChapterEntity> chapters;
  final BookChapterEntity chapterActive;
  final int currentPage;
  const BookCreateState({
    this.targets = const [],
    this.categories = const [],
    this.selectedIndexChapter = 0,
    this.chapters = const [],
    this.chapterActive = const BookChapterEntity.empty(),
    this.currentPage = 0,
  });

  BookCreateState copyWith({
    List<String>? targets,
    List<CategoryUserEntity>? categories,
    int? selectedIndexChapter,
    List<BookChapterEntity>? chapters,
    BookChapterEntity? chapterActive,
    int? currentPage,
  }) {
    return BookCreateState(
      targets: targets ?? this.targets,
      categories: categories ?? this.categories,
      selectedIndexChapter: selectedIndexChapter ?? this.selectedIndexChapter,
      chapters: chapters ?? this.chapters,
      chapterActive: chapterActive ?? this.chapterActive,
      currentPage: currentPage ?? this.currentPage
    );
  }
  
  @override
  List<Object> get props => [
    targets,
    categories,
    selectedIndexChapter,
    chapters,
    chapterActive,
    currentPage
  ];
}
