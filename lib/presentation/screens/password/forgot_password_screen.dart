import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:h3_14_bookie/domain/services/auth_service.dart';
import 'package:h3_14_bookie/presentation/screens/password/recovery_method_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const String name = 'forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                '¿Olvidaste tu contraseña?',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Necesitamos identificarte. Luego podrás cambiar tu contraseña.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Ingresa tu correo electrónico o usuario',
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006494),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 56),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecoveryMethodScreen(
                              email: _emailController.text)));
                },
                // onPressed: _isLoading ? null : _handleContinue,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Continuar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _handleContinue() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Por favor ingresa tu correo electrónico',
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Intentar verificar el email
      final emailExists = await AuthService().verifyEmail(email);

      if (mounted) {
        if (emailExists) {
          // Si el email existe, navegamos a la pantalla de recuperación
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RecoveryMethodScreen(email: email),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      // Manejar errores específicos de Firebase
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No existe una cuenta con este correo electrónico';
          break;
        case 'invalid-email':
          errorMessage = 'El formato del correo electrónico no es válido';
          break;
        case 'too-many-requests':
          errorMessage = 'Demasiados intentos. Por favor, intenta más tarde';
          break;
        default:
          errorMessage = 'Ha ocurrido un error. Por favor, intenta nuevamente';
      }

      Fluttertoast.showToast(
        msg: errorMessage,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      // Manejar otros errores inesperados
      print('Error inesperado: $e');
      Fluttertoast.showToast(
        msg: 'Ha ocurrido un error inesperado',
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
