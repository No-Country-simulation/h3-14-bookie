import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/presentation/screens/home/home.dart';
import 'package:h3_14_bookie/presentation/screens/login/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<UserCredential> signup({
    required String email,
    required String password,
    required String name,
    required String username,
  }) async {
    try {
      // Validar campos vacíos
      if (email.trim().isEmpty ||
          password.trim().isEmpty ||
          name.trim().isEmpty ||
          username.trim().isEmpty) {
        throw FirebaseAuthException(
          code: 'empty-fields',
          message: 'Todos los campos son obligatorios.',
        );
      }

      // Validar formato de email
      final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegExp.hasMatch(email)) {
        throw FirebaseAuthException(
          code: 'invalid-email-format',
          message: 'El formato del correo electrónico no es válido.',
        );
      }

      // Validaciones de contraseña
      if (password.length < 6) {
        throw FirebaseAuthException(
          code: 'weak-password',
          message: 'La contraseña debe tener al menos 6 caracteres.',
        );
      }

      // Validar complejidad de contraseña
      final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      final hasLowerCase = password.contains(RegExp(r'[a-z]'));
      final hasNumbers = password.contains(RegExp(r'[0-9]'));
      final hasSpecialCharacters =
          password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

      if (!hasUpperCase ||
          !hasLowerCase ||
          !hasNumbers ||
          !hasSpecialCharacters) {
        throw FirebaseAuthException(
          code: 'password-requirements',
          message:
              'La contraseña debe contener al menos una mayúscula, una minúscula, un número y un carácter especial.',
        );
      }

      // Validar nombre de usuario si se proporciona
      if (username.trim().isEmpty || username.length < 3) {
        throw FirebaseAuthException(
          code: 'invalid-username',
          message: 'El nombre de usuario debe tener al menos 3 caracteres.',
        );
      }
      // Verificar que solo contenga caracteres alfanuméricos y guiones bajos
      if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
        throw FirebaseAuthException(
          code: 'invalid-username-format',
          message:
              'El nombre de usuario solo puede contener letras, números y guiones bajos.',
        );
      }

      // Validar nombre
      if (name.trim().length < 2) {
        throw FirebaseAuthException(
          code: 'invalid-name',
          message: 'El nombre debe tener al menos 2 caracteres.',
        );
      }

      // Verificar si el email ya existe
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        throw FirebaseAuthException(
          code: 'email-already-in-use',
          message: 'Ya existe una cuenta con este correo electrónico.',
        );
      }

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'weak-password':
          message = 'La contraseña proporcionada es muy débil.';
          break;
        case 'email-already-in-use':
          message = 'Ya existe una cuenta con este correo electrónico.';
          break;
        case 'invalid-email-format':
          message = 'El formato del correo electrónico no es válido.';
          break;
        case 'empty-fields':
          message = 'Todos los campos son obligatorios.';
          break;
        case 'password-requirements':
          message =
              'La contraseña debe contener al menos una mayúscula, una minúscula, un número y un carácter especial.';
          break;
        case 'invalid-username':
        case 'invalid-username-format':
          message = e.message ?? 'El nombre de usuario no es válido.';
          break;
        case 'invalid-name':
          message = 'El nombre no puede estar vacío.';
          break;
        default:
          message = e.message ?? 'Ha ocurrido un error durante el registro.';
      }

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      throw FirebaseAuthException(
        code: e.code,
        message: message,
      );
    }
  }

  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // Mostrar pantalla de carga
      if (context.mounted) {
        context.go('/loading');
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // La redirección al home la manejará el router automáticamente
    } catch (e) {
      // En caso de error, volver a la pantalla de login
      if (context.mounted) {
        context.go('/initScreen');
      }
      rethrow;
    }
  }

  Future<void> signout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      context.go('/login');
    }
  }

  Future<bool> verifyEmail(String email) async {
    try {
      // Primero verificamos si el email tiene un formato válido
      if (!email.contains('@') || !email.contains('.')) {
        throw FirebaseAuthException(
          code: 'invalid-email',
          message: 'El formato del correo electrónico no es válido',
        );
      }

      // Verificar si el email existe usando el servicio de autenticación
      try {
        final methods =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        print('Métodos de autenticación disponibles: $methods'); // Debug

        // Si no hay métodos de inicio de sesión, el usuario no existe
        if (methods.isEmpty) {
          throw FirebaseAuthException(
            code: 'user-not-found',
            message: 'No existe una cuenta con este correo electrónico',
          );
        }

        // Si llegamos aquí, el usuario existe
        return true;
      } on FirebaseException catch (e) {
        print('Firebase Exception: ${e.code} - ${e.message}');
        if (e.code == 'invalid-email') {
          throw FirebaseAuthException(
            code: 'invalid-email',
            message: 'El formato del correo electrónico no es válido',
          );
        }
        rethrow;
      }
    } catch (e) {
      print('Error en verifyEmail: $e');
      if (e is FirebaseAuthException) {
        rethrow;
      }
      throw FirebaseAuthException(
        code: 'unknown',
        message: 'Ha ocurrido un error al verificar el correo electrónico',
      );
    }
  }

  Future<void> sendRecoveryLink(String email, String method) async {
    try {
      if (method == 'email') {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      } else {
        // Implementar envío por SMS si se requiere
        throw UnimplementedError('Método SMS no implementado');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Inicia el flujo de autenticación de Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        Fluttertoast.showToast(
          msg: 'Inicio de sesión con Google cancelado por el usuario.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        return;
      }

      // Obtén los detalles de autenticación
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Crea las credenciales de Google
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Inicia sesión en Firebase con las credenciales de Google
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (context.mounted) {
        context.go('/home/0');
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: 'Error de autenticación: ${e.message}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error inesperado durante el inicio de sesión',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }
}
