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
              Text(
                'Registro',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Para comenzar, crea tu cuenta.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 32),
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
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Correo electrónico',
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _userController,
          decoration: InputDecoration(
            hintText: 'Usuario',
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: 'Contraseña',
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(16),
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
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF006494),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
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
              await AuthService().signup(
                email: _emailController.text,
                password: _passwordController.text,
                name: _nameController.text,
                username: _userController.text,
              );
              await addUser(
                _emailController.text,
                _nameController.text,
                _passwordController.text,
                _userController.text,
              );

              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const UserCreated()),
                );
              }
            } catch (e) {
              // El error ya se maneja en AuthService
            }
          },
          child: const Text(
            'Registrarme',
            style: TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Al registrarte, aceptas nuestros Términos de uso y Política de Privacidad',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
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
                style: TextStyle(color: Colors.blue.shade700),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
