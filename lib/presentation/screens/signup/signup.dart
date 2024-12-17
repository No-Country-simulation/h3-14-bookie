import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:h3_14_bookie/domain/services/auth_service.dart';
import 'package:h3_14_bookie/domain/services/firebase_service.dart';
import 'package:h3_14_bookie/presentation/screens/login/login.dart';
import 'package:h3_14_bookie/presentation/screens/signup/user_created.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  static const String name = 'Signup';

  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Registro',
                  style: GoogleFonts.inter(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Para comenzar, crea tu cuenta.',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 80),
              _signupForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signupForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Nombre completo',
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Correo electrónico',
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _userController,
          decoration: InputDecoration(
            hintText: 'Usuario',
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: 'Contraseña',
            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 50),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF006494),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 47),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 0,
          ),
          onPressed: () async {
            // Validar que todos los campos estén llenos
            if (_nameController.text.trim().isEmpty ||
                _emailController.text.trim().isEmpty ||
                _userController.text.trim().isEmpty ||
                _passwordController.text.trim().isEmpty) {
              Fluttertoast.showToast(
                msg: 'Todos los campos son obligatorios',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
                fontSize: 14.0,
              );
              return;
            }

            try {
              // Deshabilitar el botón mientras se procesa
              setState(() {
                _isLoading = true;
              });

              // Realizar el registro
              await AuthService().signup(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
                name: _nameController.text.trim(),
                username: _userController.text.trim(),
                context: context,
              );

              await addUser(
                _emailController.text.trim(),
                _nameController.text.trim(),
                _passwordController.text.trim(),
                _userController.text.trim(),
              );

              // Iniciar sesión sin redirección automática al home
              if (context.mounted) {
                await AuthService().signin(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                  context: context,
                  redirectToHome: false,
                );
              }

              if (context.mounted) {
                // Navegar a la pantalla de usuario creado
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const UserCreated()),
                  (route) => false,
                );
              }
            } catch (e) {
            } finally {
              // Asegurarse de que el botón se habilite nuevamente
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            }
          },
          child: const Text(
            'Registrarme',
            style: TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 47),
        _termsAndConditions(),
        const SizedBox(height: 47),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¿Ya tienes tu cuenta? ',
              style: TextStyle(color: Colors.black87),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text(
                'Iniciar sesión',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue.shade700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _termsAndConditions() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 14,
        ),
        children: [
          const TextSpan(
            text: 'Al registrarte, aceptas nuestros ',
          ),
          TextSpan(
            text: 'Términos de uso',
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => TermsScreen()),
                // );
              },
          ),
          const TextSpan(
            text: ' y ',
          ),
          TextSpan(
            text: 'Política de Privacidad',
            style: const TextStyle(
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => PrivacyScreen()),
                // );
              },
          ),
        ],
      ),
    );
  }
}
