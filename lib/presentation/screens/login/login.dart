import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/domain/services/auth_service.dart';
import 'package:h3_14_bookie/presentation/screens/loading/loading_screen.dart';
import 'package:h3_14_bookie/presentation/screens/password/forgot_password_screen.dart';
import 'package:h3_14_bookie/presentation/screens/signup/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  static const String name = 'Login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Text(
                  'Inicio de sesión',
                  style: GoogleFonts.inter(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Para comenzar, ingresa a tu cuenta.',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 150),
              _socialButtons(),
              const SizedBox(height: 16),
              _divider(),
              const SizedBox(height: 16),
              _loginForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialButton(
          'assets/images/google_icon.png',
          onTap: () {
            // Implementar login con Google
          },
        ),
        const SizedBox(width: 47),
        _socialButton(
          'assets/images/facebook_icon.png',
          onTap: () {
            // Implementar login con Facebook
          },
        ),
      ],
    );
  }

  Widget _socialButton(String iconPath, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 47,
        height: 47,
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.8),
              blurRadius: 8,
              offset: const Offset(0, 4), // Cambiado a 4 para sombra más abajo
            ),
          ],
        ),
        child: Image.asset(iconPath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 100,
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey.shade500, thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'O',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey.shade500, thickness: 1)),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Usuario o correo electrónico',
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
          obscureText: _obscureText,
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
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey.shade600,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 32),
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
            // Validar que los campos no estén vacíos
            if (_emailController.text.trim().isEmpty ||
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
              await AuthService().signin(
                email: _emailController.text,
                password: _passwordController.text,
                context: context,
              );
            } catch (e) {
              // El error ya se maneja en AuthService
            }
          },
          child: const Text(
            'Iniciar sesión',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen()));
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 32),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              '¿Olvidaste tu contraseña?',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¿Aún no tienes tu cuenta? ',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signup()),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 32),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Regístrate',
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
}
