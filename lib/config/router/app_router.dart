import 'package:firebase_auth/firebase_auth.dart';
import 'package:h3_14_bookie/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/router/auth_refresh_stream.dart';
import 'package:h3_14_bookie/presentation/screens/init/init_screen.dart';
import 'package:h3_14_bookie/presentation/screens/signup/user_created.dart';
import 'package:h3_14_bookie/presentation/screens/password/forgot_password_screen.dart';
import 'package:h3_14_bookie/presentation/screens/splash/splash_screen.dart';

// Crear un listenable para escuchar cambios en el estado de autenticación
final authStateChanges = FirebaseAuth.instance.authStateChanges();

final appRouter = GoRouter(
  initialLocation: '/',
  // Escuchar cambios de autenticación
  refreshListenable: GoRouterRefreshStream(authStateChanges),
  routes: [
    // Ruta del Splash Screen
    GoRoute(
      path: '/',
      name: SplashScreen.name,
      builder: (context, state) => const SplashScreen(),
    ),
    // Ruta principal protegida (Home)
    GoRoute(
        path: '/home/:page',
        name: HomeScreen.name,
        builder: (context, state) {
          final pageIndex = state.pathParameters['page'] ?? '0';
          return HomeScreen(pageIndex: int.parse(pageIndex));
        },
        routes: [
          GoRoute(
              path: 'book/:id',
              name: BookInfoScreen.name,
              builder: (context, state) {
                final movieId = state.pathParameters['id'] ?? 'no-id';
                return BookInfoScreen(bookId: movieId);
              },
              routes: [
                GoRoute(
                  path: 'read',
                  name: BookReadScreen.name,
                  builder: (context, state) {
                    return const BookReadScreen();
                  },
                ),
              ]),
          GoRoute(
              path: '/book-create',
              name: BookCreateScreen.name,
              builder: (context, state) => const BookCreateScreen(),
              routes: [
                GoRoute(
                  path: '/tags',
                  name: BookTagsScreen.name,
                  builder: (context, state) => const BookTagsScreen(),
                ),
                GoRoute(
                  path: '/categories',
                  name: BookCategoriesScreen.name,
                  builder: (context, state) => const BookCategoriesScreen(),
                ),
                GoRoute(
                  path: '/chapter-edit',
                  name: ChapterEditScreen.name,
                  builder: (context, state) => const ChapterEditScreen(),
                ),
              ]),
        ]),
    // Ruta de inicio de sesión
    GoRoute(
      path: '/initScreen',
      name: InitScreen.name,
      builder: (context, state) => InitScreen(),
    ),
    // Ruta de usuario creado
    GoRoute(
      path: '/user-created',
      name: UserCreated.name,
      builder: (context, state) => const UserCreated(),
    ),
    // Ruta de recuperación de contraseña
    GoRoute(
      path: '/forgot-password',
      name: ForgotPasswordScreen.name,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
  ],
  // Redirección basada en el estado de autenticación
  redirect: (context, state) async {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final isGoingToLogin = state.matchedLocation == '/initScreen';
    final isInSplash = state.matchedLocation == '/';

    // No redirigir si está en el splash
    if (isInSplash) return null;

    // Si no está logueado y no va al login, redirigir al login
    if (!isLoggedIn && !isGoingToLogin) {
      return '/initScreen';
    }

    // Si está logueado y va al login, redirigir a home
    if (isLoggedIn && isGoingToLogin) {
      return '/home/0';
    }

    return null;
  },
);
