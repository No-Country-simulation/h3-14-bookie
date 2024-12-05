import 'package:firebase_auth/firebase_auth.dart';
import 'package:h3_14_bookie/presentation/screens/book_read_screen.dart';
import 'package:h3_14_bookie/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/router/auth_refresh_stream.dart';
import 'package:h3_14_bookie/presentation/screens/init/init_screen.dart';
import 'package:h3_14_bookie/presentation/screens/signup/user_created.dart';

// Crear un listenable para escuchar cambios en el estado de autenticación
final authStateChanges = FirebaseAuth.instance.authStateChanges();

final appRouter = GoRouter(
  initialLocation: '/initScreen',
  // Escuchar cambios de autenticación
  refreshListenable: GoRouterRefreshStream(authStateChanges),
  routes: [
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
          ]
        ),
      ]
    ),
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
  ],
  // Redirección basada en el estado de autenticación
  redirect: (context, state) async {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final isGoingToLogin = state.matchedLocation == '/initScreen';

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
