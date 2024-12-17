import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/domain/model/dto/user_dto.dart';
import 'package:h3_14_bookie/domain/services/implement/app_user_service_impl.dart';
import 'package:h3_14_bookie/domain/services/app_user_service.dart';
import 'package:h3_14_bookie/presentation/screens/home/home.dart';
import 'package:h3_14_bookie/presentation/screens/login/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:h3_14_bookie/presentation/screens/auth/email_verification_screen.dart';
import 'package:h3_14_bookie/presentation/widgets/dialogs/error_dialog.dart';

class AuthService {
  Future<UserCredential> signup({
    required String email,
    required String password,
    required String name,
    required String username,
    required BuildContext context,
  }) async {
    final IAppUserService appUserService = AppUserServiceImpl();

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
      // final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      // final hasLowerCase = password.contains(RegExp(r'[a-z]'));
      // final hasNumbers = password.contains(RegExp(r'[0-9]'));
      // final hasSpecialCharacters =
      //     password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

      // if (!hasUpperCase ||
      //     !hasLowerCase ||
      //     !hasNumbers ||
      //     !hasSpecialCharacters) {
      //   throw FirebaseAuthException(
      //     code: 'password-requirements',
      //     message:
      //         'La contraseña debe contener al menos una mayúscula, una minúscula, un número y un carácter especial.',
      //   );
      // }

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

      // Enviar correo de verificación
      await userCredential.user!.sendEmailVerification();

      await appUserService.createAppUser(UserDto(
        authUserUid: userCredential.user!.uid,
        name: username,
        email: email,
      ));

      // Mostrar mensaje de éxito y redirigir a la pantalla de verificación
      // Fluttertoast.showToast(
      //   msg: 'Cuenta creada exitosamente. Por favor, verifica tu email.',
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.SNACKBAR,
      //   backgroundColor: Colors.green,
      //   textColor: Colors.white,
      //   fontSize: 14.0,
      // );

      // Navegar a la pantalla de verificación de email
      if (context.mounted) {
        context.go('/email-verification');
      }

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
    bool redirectToHome = true,
  }) async {
    try {
      // Validar que los campos no estén vacíos
      if (email.trim().isEmpty || password.trim().isEmpty) {
        if (context.mounted) {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Campos Vacíos'),
                content: const Text('Por favor, complete todos los campos.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Aceptar'),
                  ),
                ],
              );
            },
          );
        }
        return;
      }

      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        if (!userCredential.user!.emailVerified) {
          await userCredential.user!.sendEmailVerification();
          await FirebaseAuth.instance.signOut();

          if (context.mounted) {
            context.go('/email-verification');
          }
          return;
        }

        print('UID del usuario: ${userCredential.user?.uid}');

        if (context.mounted) {
          if (redirectToHome) {
            context.go('/loading');
          } else {
            context.go('/user-created');
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException en signin: ${e.code} - ${e.message}');

      if (context.mounted) {
        String errorMessage = '';

        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No existe una cuenta con este correo electrónico.';
            break;
          case 'wrong-password':
            errorMessage = 'La contraseña es incorrecta.';
            break;
          case 'invalid-email':
            errorMessage = 'El formato del correo electrónico no es válido.';
            break;
          case 'user-disabled':
            errorMessage = 'Esta cuenta ha sido deshabilitada.';
            break;
          case 'too-many-requests':
            errorMessage = 'Demasiados intentos fallidos. Intente más tarde.';
            break;
          default:
            errorMessage =
                ' ${"No hemos podido encontrar un registro de usuario con el correo electrónico ingresado."}';
        }
        ErrorDialog.show(context, message: errorMessage);
        // await showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: const Text('Error de Inicio de Sesión'),
        //       content: Text(errorMessage),
        //       actions: [
        //         TextButton(
        //           onPressed: () => Navigator.pop(context),
        //           child: const Text('Aceptar'),
        //         ),
        //       ],
        //     );
        //   },
        // );
      }
    } catch (e) {
      print('Error inesperado en signin: $e');
      if (context.mounted) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text(
                  'Ocurrió un error inesperado. Por favor, intente nuevamente.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Aceptar'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> signout({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        context.go('/initScreen');
      }
    } catch (e) {
      print('Error en signout: $e');
      Fluttertoast.showToast(
        msg: 'Error al cerrar sesión',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
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

  Future<bool> verifyEmail(String email) async {
    try {
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } catch (e) {
      print('Error en verifyEmail: $e');
      return false;
    }
  }
}
