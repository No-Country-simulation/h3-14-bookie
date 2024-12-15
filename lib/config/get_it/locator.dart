import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:h3_14_bookie/domain/services/implement/app_user_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/category_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/chapter_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/image_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/reading_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/story_service_impl.dart';
import 'package:h3_14_bookie/domain/services/implement/writing_service_impl.dart';
import 'package:h3_14_bookie/presentation/blocs/book/favorite_view/favorite_view_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/book/book_create/book_create_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/book/edit_view/edit_view_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/book/navigation_view/navigation_view_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/book/read_view/read_view_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/home_view/home_view_bloc.dart';

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
    appUserService: AppUserServiceImpl()
  ));
  locator.registerSingleton(HomeViewBloc(
    storyService: StoryServiceImpl(),
    readingService: ReadingServiceImpl(),
    categoryService: CategoryServiceImpl(),
  ));
  locator.registerSingleton(ReadViewBloc());
  locator.registerSingleton(FavoriteViewBloc(
    readingService: ReadingServiceImpl()
  ));
  locator.registerSingleton(NavigationViewBloc(
    chapterService: ChapterServiceImpl(),
  ));
}
