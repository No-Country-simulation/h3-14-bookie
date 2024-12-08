
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h3_14_bookie/domain/entities/book_chapter_entity.dart';
import 'package:h3_14_bookie/domain/entities/category_user_entity.dart';
import 'package:h3_14_bookie/domain/model/dto/story_dto.dart';
import 'package:h3_14_bookie/domain/services/implement/category_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/story_service_impl.dart';

part 'book_create_event.dart';
part 'book_create_state.dart';

class BookCreateBloc extends Bloc<BookCreateEvent, BookCreateState> {
  final StoryServiceImpl storyService;
  final CategoryServiceImpl categoryService;
  BookCreateBloc({
    required this.storyService,
    required this.categoryService,
  }) : super(const BookCreateState()) {
    on<AddTargetEvent>(_onAddTargetEvent);
    on<InitCategoriesEvent>(_onInitCategoriesEvent);
    on<ToogleCategoryEvent>(_onToogleCategoryEvent);
    on<AddInitialChapterEvent>(_onAddInitialChapterEvent);
    on<UpdateChapterActive>(_onUpdateChapterActive);
    on<SaveChapterActive>(_onSaveChapterActive);
    on<UpdateCurrentPage>(_onUpdateCurrentPage);
    on<AddChapterEvent>(_onAddChapterEvent);
    on<CreateStoryEvent>(_onCreateStoryEvent);
  }

  void _onAddTargetEvent(AddTargetEvent event, Emitter<BookCreateState> emit) {
    List<String> list = List.from(state.targets);
    list.add(event.target.replaceAll(' ', '_'));
    emit(state.copyWith(
      targets: list
    ));
  }

  void _onInitCategoriesEvent(InitCategoriesEvent event, Emitter<BookCreateState> emit) async {
    // emit(state.copyWith(
    //   categories: const [
    //   CategoryUserEntity(name: 'Terror', isActive: false, uid: 'TwCqJ2CTCovsw9kKTshD'),
    //   CategoryUserEntity(name: 'Acción', isActive: false, uid: 'UxFIrMmyHp7vvVOtFeSU'),
    //   CategoryUserEntity(name: 'Aventura', isActive: false, uid: 'gweHAz8bWKI6kndD3QHs'),
    //   CategoryUserEntity(name: 'Ciencia Ficción', isActive: false, uid: 'rqD1BLqKKq1tKPTXzVJC'),
    //   CategoryUserEntity(name: 'Fantasy', isActive: false, uid: 'TwCqJ2CTCovsw9kKTshD'),
    // ]
    // ));
    try{
      final categories = await categoryService.getCategories();
      emit(state.copyWith(
        categories: categories.map((c)=>CategoryUserEntity(name: c.name, isActive: false, uid: c.uid)).toList()
      ));
    }catch(e) {
      Fluttertoast.showToast(msg: '$e');
    }
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

  void _onCreateStoryEvent(CreateStoryEvent event, Emitter<BookCreateState> emit) async {
    try{
      final uuidStory = await storyService.createStory(event.story);
      emit(state.copyWith(
        storyId: uuidStory
      ));
    }catch(e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }
}
