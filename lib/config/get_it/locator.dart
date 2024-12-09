import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:h3_14_bookie/domain/services/implement/category_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/chapter_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/image_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/story_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/writing_service_impl.dart';
import 'package:h3_14_bookie/presentation/blocs/book/book_create/book_create_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/book/edit_view/edit_view_bloc.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => GlobalKey<ScaffoldState>());

  locator.registerSingleton(BookCreateBloc(
    storyService: StoryServiceImpl(),
    categoryService: CategoryServiceImpl(),
    chapterService: ChapterServiceImpl(),
    imageService: ImageServiceImpl(),
  ));
  locator.registerSingleton(EditViewBloc(
    writingService: WritingServiceImpl(),
  ));
}
