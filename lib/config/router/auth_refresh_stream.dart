import 'dart:async';
import 'package:flutter/foundation.dart';

/// Clase que extiende [ChangeNotifier] para escuchar cambios en un [Stream].
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;
  bool _isDisposed =
      false; // Variable para evitar notificaciones después de la disposición.

  GoRouterRefreshStream(Stream<dynamic> stream) {
    // Escucha el stream y notifica a los listeners de cambios.
    _subscription = stream.asBroadcastStream().listen((_) {
      if (!_isDisposed) {
        notifyListeners();
      }
    }, onError: (error) {
      // Manejo opcional de errores del stream.
      if (kDebugMode) {
        print('Error en el stream: $error');
      }
    });
  }

  @override
  void dispose() {
    _isDisposed =
        true; // Marca como "disposed" antes de cancelar la suscripción.
    _subscription.cancel(); // Cancela la suscripción al stream.
    super.dispose();
  }
}
