// import 'package:bookie_test/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/book/favorite_view/favorite_view_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/book/book_create/book_create_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/book/edit_view/edit_view_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/book/navigation_view/navigation_view_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/book/read_view/read_view_bloc.dart';
import 'package:h3_14_bookie/presentation/blocs/home_view/home_view_bloc.dart';
import 'firebase_options.dart';
import 'package:h3_14_bookie/config/get_it/locator.dart';
import 'package:h3_14_bookie/config/router/app_router.dart';
import 'package:h3_14_bookie/config/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Verificar si Firebase ya está inicializado
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  setupLocator();
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<BookCreateBloc>(),
        ),
        BlocProvider(
          create: (_) => locator<EditViewBloc>()..add(const GetStories()),
        ),
        BlocProvider(
          create: (_) => locator<HomeViewBloc>()..add(const InitHomeEvent()),
        ),
        BlocProvider(
          create: (_) => locator<ReadViewBloc>(),
        ),
        BlocProvider(
          create: (_) =>
              locator<FavoriteViewBloc>()..add(const InitFavoritesEvent()),
          lazy: false,
        ),
        BlocProvider(
          create: (_) =>
              locator<NavigationViewBloc>()..add(const GetStoryChapterEvent()),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
