import 'package:firebase_auth/firebase_auth.dart';
import 'package:h3_14_bookie/presentation/screens/book_read_screend.dart';
import 'package:h3_14_bookie/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/router/auth_refresh_stream.dart';
import 'package:h3_14_bookie/presentation/screens/login/login.dart';

// Crear un listenable para escuchar cambios en el estado de autenticación
final authStateChanges = FirebaseAuth.instance.authStateChanges();

final appRouter = GoRouter(
  initialLocation: '/login',
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
              name: BookReadScreend.name,
              builder: (context, state) {
                return const BookReadScreend();
              },
            ),
          ]
        ),
      ]
    ),
    // Ruta de inicio de sesión
    GoRoute(
      path: '/login',
      name: Login.name,
      builder: (context, state) => Login(),
    ),
  ],
  // Redirección basada en el estado de autenticación
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final goingToLogin = state.uri.toString() == '/login';

    // Si el usuario está logueado y va a /login, redirigir a /home/0
    if (isLoggedIn && goingToLogin) return '/home/0';

    // Si el usuario no está logueado y no está en /login, redirigir a /login
    if (!isLoggedIn && state.uri.toString() != '/login') return '/login';

    return null; // No redirección necesaria
  },
);
