
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h3_14_bookie/domain/entities/book_chapter_entity.dart';
import 'package:h3_14_bookie/domain/entities/category_user_entity.dart';

part 'book_create_event.dart';
part 'book_create_state.dart';

class BookCreateBloc extends Bloc<BookCreateEvent, BookCreateState> {
  BookCreateBloc() : super(const BookCreateState()) {
    on<AddTargetEvent>(_onAddTargetEvent);
    on<InitCategoriesEvent>(_onInitCategoriesEvent);
    on<ToogleCategoryEvent>(_onToogleCategoryEvent);
    on<AddInitialChapterEvent>(_onAddInitialChapterEvent);
    on<UpdateChapterActive>(_onUpdateChapterActive);
    on<SaveChapterActive>(_onSaveChapterActive);
    on<UpdateCurrentPage>(_onUpdateCurrentPage);
    on<AddChapterEvent>(_onAddChapterEvent);
  }

  void _onAddTargetEvent(AddTargetEvent event, Emitter<BookCreateState> emit) {
    List<String> list = List.from(state.targets);
    list.add(event.target.replaceAll(' ', '_'));
    emit(state.copyWith(
      targets: list
    ));
  }

  void _onInitCategoriesEvent(InitCategoriesEvent event, Emitter<BookCreateState> emit) {
    emit(state.copyWith(
      categories: const [
      CategoryUserEntity(name: 'Terror', isActive: false, uid: '1'),
      CategoryUserEntity(name: 'Acción', isActive: false, uid: '2'),
      CategoryUserEntity(name: 'Aventura', isActive: false, uid: '3'),
      CategoryUserEntity(name: 'Ciencia Ficción', isActive: false, uid: '4'),
      CategoryUserEntity(name: 'Fanfic', isActive: false, uid: '5'),
    ]
    ));
  }

  void _onToogleCategoryEvent(ToogleCategoryEvent event, Emitter<BookCreateState> emit) {
    emit(state.copyWith(
      categories: state.categories.map((c){
        if(c.uid == event.uidCategory){
          return c.copyWith(isActive: !c.isActive);
        }
        return c;
      }).toList()
    ));
  }

  void _onAddInitialChapterEvent(AddInitialChapterEvent event, Emitter<BookCreateState> emit) {
    final chapter = BookChapterEntity(
      uid: '',
      placeName: event.placeName,
      titleChapter: event.title,
      pages: const ['']
    );
    emit(state.copyWith(
      chapters: [chapter],
      selectedIndexChapter: 0,
      chapterActive: chapter,
    ));
  }

  void _onUpdateChapterActive(UpdateChapterActive event, Emitter<BookCreateState> emit) {
    emit(state.copyWith(
      chapterActive: event.chapter,
    ));
    print('EL TAMAÑOOO es ${state.chapterActive.pages.length}');
    if(event.whenComplete != null) {
      event.whenComplete!();
    }
  }

  void _onSaveChapterActive(SaveChapterActive event, Emitter<BookCreateState> emit) {
    List<BookChapterEntity> list = List.from(state.chapters);
    int index = list.indexWhere((c) => c.uid == event.chapter.uid); 
    if (index != -1) { list[index] = event.chapter; }
    else { list.add(event.chapter); }
    emit(state.copyWith(
      chapters: list
    ));
  }

  void _onUpdateCurrentPage(UpdateCurrentPage event, Emitter<BookCreateState> emit) {
    emit(state.copyWith(
      currentPage: event.page
    ));
  }

  void _onAddChapterEvent(AddChapterEvent event, Emitter<BookCreateState> emit) {
    const chapter = BookChapterEntity(
      uid: '',
      placeName: '',
      titleChapter: '',
      pages: ['']
    );
    emit(state.copyWith(
      chapters: [...state.chapters,chapter],
      selectedIndexChapter: state.chapters.length + 1,
      chapterActive: chapter,
    ));
  }
}
