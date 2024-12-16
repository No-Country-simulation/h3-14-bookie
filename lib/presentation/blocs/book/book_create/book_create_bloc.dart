import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h3_14_bookie/domain/entities/book_chapter_entity.dart';
import 'package:h3_14_bookie/domain/entities/category_user_entity.dart';
import 'package:h3_14_bookie/domain/model/dto/chapter_dto.dart';
import 'package:h3_14_bookie/domain/model/dto/story_dto.dart';
import 'package:h3_14_bookie/domain/services/category_service.dart';
import 'package:h3_14_bookie/domain/services/chapter_service.dart';
import 'package:h3_14_bookie/domain/services/image_service.dart';
import 'package:h3_14_bookie/domain/services/story_service.dart';

part 'book_create_event.dart';
part 'book_create_state.dart';

class BookCreateBloc extends Bloc<BookCreateEvent, BookCreateState> {
  final IStoryService storyService;
  final ICategoryService categoryService;
  final IChapterService chapterService;
  final IImageService imageService;
  BookCreateBloc({
    required this.storyService,
    required this.categoryService,
    required this.chapterService,
    required this.imageService,
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
    on<CreateChapterEvent>(_onCreateChapterEvent);
    on<ResetValuesBookCreateEvent>(_onResetValuesReadViewEvent);
    on<SaveStoryEvent>(_onSaveStoryEvent);
    on<ChangeChapterActive>(_onChangeChapterActive);
    on<DeleteTargetEvent>(_onDeleteTargetEvent);
    on<DeleteChapterEvent>(_onDeleteChapterEvent);
  }

  void _onAddTargetEvent(AddTargetEvent event, Emitter<BookCreateState> emit) {
    List<String> list = List.from(state.targets);
    list.add(event.target.replaceAll(' ', '_'));
    emit(state.copyWith(targets: list));
  }

  void _onInitCategoriesEvent(
      InitCategoriesEvent event, Emitter<BookCreateState> emit) async {
    try {
      final categories = await categoryService.getCategories();
      emit(state.copyWith(
          categories: categories
              .map((c) =>
                  CategoryUserEntity(name: c.name, isActive: false, uid: c.uid))
              .toList()));
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  void _onToogleCategoryEvent(
      ToogleCategoryEvent event, Emitter<BookCreateState> emit) {
    emit(state.copyWith(
        categories: state.categories.map((c) {
      if (c.uid == event.uidCategory) {
        return c.copyWith(isActive: !c.isActive);
      }
      return c;
    }).toList()));
  }

  void _onAddInitialChapterEvent(
      AddInitialChapterEvent event, Emitter<BookCreateState> emit) {
    final chapter = BookChapterEntity(
        number: 1,
        uid: '',
        placeName: event.placeName,
        titleChapter: event.title,
        pages: const ['']);
    emit(state.copyWith(
      chapters: [chapter],
      selectedIndexChapter: 0,
      chapterActive: chapter,
    ));
  }

  void _onUpdateChapterActive(
      UpdateChapterActive event, Emitter<BookCreateState> emit) {
    List<BookChapterEntity> list = List.from(state.chapters);
    int index = list.indexWhere((c) => c.number == event.chapter.number);
    if (index != -1) {
      list[index] = event.chapter;
    }
    emit(state.copyWith(
        chapterActive: event.chapter, chapters: list, storySave: false));
    if (event.whenComplete != null) {
      event.whenComplete!();
    }
  }

  void _onSaveChapterActive(
      SaveChapterActive event, Emitter<BookCreateState> emit) {
    try {
      storyService.addNewChapterToStory(ChapterDto(
          storyUid: state.storyId,
          title: event.chapter.titleChapter,
          pages: event.chapter.pages,
          placeName: event.chapter.placeName,
          lat: event.chapter.position.latitude,
          long: event.chapter.position.longitude));
      List<BookChapterEntity> list = List.from(state.chapters);
      int index = list.indexWhere((c) => c.number == event.chapter.number);
      if (index != -1) {
        list[index] = event.chapter;
      } else {
        list.add(event.chapter);
      }
      list.add(event.chapter);
      emit(state.copyWith(chapters: list));
      Fluttertoast.showToast(msg: 'Cambios guardados.');
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  void _onUpdateCurrentPage(
      UpdateCurrentPage event, Emitter<BookCreateState> emit) {
    emit(state.copyWith(currentPage: event.page));
  }

  void _onAddChapterEvent(
      AddChapterEvent event, Emitter<BookCreateState> emit) {
    final chapter = BookChapterEntity(
      number: state.chapters.length + 1,
      uid: '',
      placeName: '',
      titleChapter: '',
      pages: const [''],
    );
    List<BookChapterEntity> list = List.from(state.chapters);
    // int index = list.indexWhere((c) => c.number == state.chapterActive.number);
    // if (index != -1) { list[index] = state.chapterActive; }
    list.add(chapter);
    emit(state.copyWith(
      chapters: list,
      selectedIndexChapter: state.chapters.length + 1,
      chapterActive: chapter,
      currentPage: 0,
    ));
  }

  void _onCreateStoryEvent(
      CreateStoryEvent event, Emitter<BookCreateState> emit) async {
    try {
      final url = await imageService.uploadImage(state.pathCover);
      final story = StoryDto(
          title: state.titleBook,
          synopsis: state.synopsisBook,
          categoriesUid: state.categories
              .where((c) => c.isActive)
              .map((c) => c.uid)
              .toList(),
          labels: state.targets,
          cover: url);
      final uuidStory = await storyService.createStory(story);
      for (var chapter in state.chapters) {
        storyService.addNewChapterToStory(ChapterDto(
            storyUid: uuidStory,
            title: chapter.titleChapter,
            pages: chapter.pages,
            placeName: chapter.placeName,
            lat: chapter.position.latitude,
            long: chapter.position.longitude));
      }
      if (event.whenComplete != null) {
        event.whenComplete!();
      }
      emit(state.copyWith(storySave: true));
      Fluttertoast.showToast(
          msg: 'Historia guardada con exito',
          backgroundColor: Colors.green[300]);
    } catch (e) {
      Fluttertoast.showToast(msg: '$e', backgroundColor: Colors.red);
    }
  }

  void _onCreateChapterEvent(
      CreateChapterEvent event, Emitter<BookCreateState> emit) async {
    try {
      for (var c in state.chapters) {
        storyService.addNewChapterToStory(ChapterDto(
            storyUid: state.storyId,
            title: c.titleChapter,
            pages: c.pages,
            placeName: c.placeName,
            lat: c.position.latitude,
            long: c.position.longitude));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  void _onResetValuesReadViewEvent(
      ResetValuesBookCreateEvent event, Emitter<BookCreateState> emit) {
    emit(state.copyWith(targets: []));
  }

  void _onSaveStoryEvent(SaveStoryEvent event, Emitter<BookCreateState> emit) {
    final chapter = BookChapterEntity(
        number: 1,
        uid: '',
        placeName: event.placeName,
        titleChapter: event.titleChapter,
        pages: const ['']);

    emit(state.copyWith(
      titleBook: event.titleBook,
      synopsisBook: event.synopsisBook,
      pathCover: event.pathImage,
      chapters: [chapter],
      selectedIndexChapter: 0,
      chapterActive: chapter,
    ));
  }

  void _onChangeChapterActive(
      ChangeChapterActive event, Emitter<BookCreateState> emit) {
    List<BookChapterEntity> list = List.from(state.chapters);
    int index = list.indexWhere((c) => c.number == event.number);
    if (index == -1) {
      return;
    }
    emit(state.copyWith(chapterActive: state.chapters[index], currentPage: 0));
  }

  void _onDeleteTargetEvent(
      DeleteTargetEvent event, Emitter<BookCreateState> emit) {
    List<String> list = List.from(state.targets);
    list.removeAt(event.index);
    emit(state.copyWith(targets: list));
  }

  void _onDeleteChapterEvent(DeleteChapterEvent event, Emitter<BookCreateState> emit) {
    List<BookChapterEntity> list = List.from(state.chapters);
    
    BookChapterEntity? chapter;
    if(state.chapterActive.number == event.number) {
      if(state.chapters.length == 1) {
          chapter = const BookChapterEntity(number: 1, uid: '', placeName: '', titleChapter: '', pages: ['']);
      } else {
        if(event.number == 1) {
          chapter = state.chapters[1].copyWith(number: 1);
        } else {
          chapter = state.chapters[0];
        }
      }
    } else {
      if(event.number == 1) {
          chapter = state.chapters[1].copyWith(number: 1);
        } else {
          chapter = state.chapters[0];
        }
    }

    List<BookChapterEntity> newList = list.where((c) => c.number != event.number).toList();
    for (int i = 0; i < newList.length; i++) {
      newList[i] = newList[i].copyWith(number: i+1);
    }
    
    emit(state.copyWith(
      chapters: newList,
      selectedIndexChapter: 0,
      chapterActive: chapter,
    ));
  }
}
