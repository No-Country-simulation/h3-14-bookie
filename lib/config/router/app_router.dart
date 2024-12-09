import 'package:firebase_auth/firebase_auth.dart';
import 'package:h3_14_bookie/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/router/auth_refresh_stream.dart';
import 'package:h3_14_bookie/presentation/screens/init/init_screen.dart';
import 'package:h3_14_bookie/presentation/screens/signup/user_created.dart';
import 'package:h3_14_bookie/presentation/screens/password/forgot_password_screen.dart';
import 'package:h3_14_bookie/presentation/screens/splash/splash_screen.dart';
import 'package:h3_14_bookie/presentation/screens/loading/loading_screen.dart';

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
    // Agregar ruta de loading
    GoRoute(
      path: '/loading',
      name: LoadingScreen.name,
      builder: (context, state) => const LoadingScreen(),
    ),
  ],
  // Redirección basada en el estado de autenticación
  redirect: (context, state) async {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final isGoingToLogin = state.matchedLocation == '/initScreen';
    final isInSplash = state.matchedLocation == '/';
    final isLoading = state.matchedLocation == '/loading';

    // No redirigir si está en el splash
    if (isInSplash) return null;

    // Si está en proceso de login, mostrar loading
    if (isLoading) {
      if (!isLoggedIn) {
        // Si no está autenticado, permitir que se muestre la pantalla de carga
        return null;
      }
      // Si está autenticado, esperar un momento y redirigir al home
      await Future.delayed(const Duration(seconds: 1));
      return '/home/0';
    }

    // Si no está logueado y no va al login, redirigir al login
    if (!isLoggedIn && !isGoingToLogin) {
      return '/initScreen';
    }

    // Si está logueado y va al login, redirigir a home
    if (isLoggedIn && isGoingToLogin) {
      return '/loading';
    }

    return null;
  },
);
