part of 'book_create_bloc.dart';

class BookCreateState extends Equatable {
  final String titleBook;
  final String synopsisBook;
  final String pathCover;
  final List<String> targets;
  final List<CategoryUserEntity> categories;
  final int selectedIndexChapter;
  final List<BookChapterEntity> chapters;
  final BookChapterEntity chapterActive;
  final int currentPage;
  final String storyId;
  final bool storySave;
  const BookCreateState({
    this.titleBook = '',
    this.synopsisBook = '',
    this.pathCover = '',
    this.targets = const [],
    this.categories = const [],
    this.selectedIndexChapter = 0,
    this.chapters = const [],
    this.chapterActive = const BookChapterEntity.empty(),
    this.currentPage = 0,
    this.storyId = '',
    this.storySave = false,
  });

  BookCreateState copyWith({
    String? titleBook,
    String? synopsisBook,
    String? pathCover,
    List<String>? targets,
    List<CategoryUserEntity>? categories,
    int? selectedIndexChapter,
    List<BookChapterEntity>? chapters,
    BookChapterEntity? chapterActive,
    int? currentPage,
    String? storyId,
    bool? storySave,
  }) {
    return BookCreateState(
      titleBook: titleBook ?? this.titleBook,
      synopsisBook: synopsisBook ?? this.synopsisBook,
      pathCover: pathCover ?? this.pathCover,
      targets: targets ?? this.targets,
      categories: categories ?? this.categories,
      selectedIndexChapter: selectedIndexChapter ?? this.selectedIndexChapter,
      chapters: chapters ?? this.chapters,
      chapterActive: chapterActive ?? this.chapterActive,
      currentPage: currentPage ?? this.currentPage,
      storyId: storyId ?? this.storyId,
      storySave: storySave ?? this.storySave
    );
  }
  
  @override
  List<Object> get props => [
    titleBook,
    synopsisBook,
    pathCover,
    targets,
    categories,
    selectedIndexChapter,
    chapters,
    chapterActive,
    currentPage,
    storyId,
    storySave,
  ];
}
