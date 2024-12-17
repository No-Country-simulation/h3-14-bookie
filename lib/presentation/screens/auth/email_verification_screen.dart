import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = true;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;

    if (!isEmailVerified) {
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified =
          FirebaseAuth.instance.currentUser?.emailVerified ?? false;
    });

    if (isEmailVerified) {
      timer?.cancel();
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        context.go('/verification-success');
      }
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(minutes: 2));
      if (mounted) setState(() => canResendEmail = true);

      // Fluttertoast.showToast(
      //   msg: 'Se ha enviado un nuevo correo de verificación',
      //   toastLength: Toast.LENGTH_LONG,
      //   gravity: ToastGravity.SNACKBAR,
      //   backgroundColor: Colors.green,
      //   textColor: Colors.white,
      //   fontSize: 14.0,
      // );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error al enviar el correo de verificación',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verificación de Email',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () async {
            // Cerrar sesión al volver atrás
            await FirebaseAuth.instance.signOut();
            if (context.mounted) {
              context.go('/login');
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Registro de usuario completado',
              style: GoogleFonts.inter(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const Icon(
              Icons.mail_outline,
              size: 250,
              color: Color(0xFF006494),
            ),
            const SizedBox(height: 24),
            Text(
              'Verifica tu correo electrónico',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Hemos enviado un correo de verificación a tu email. Por favor, revisa tu bandeja de entrada y sigue las instrucciones.',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (canResendEmail)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006494),
                  minimumSize: const Size(double.infinity, 47),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: sendVerificationEmail,
                child: const Text('Reenviar correo de verificación'),
              )
            else
              const Text(
                'Espera 2 minuto antes de solicitar un nuevo correo',
                style: TextStyle(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  context.go('/login');
                }
              },
              child: const Text('Cancelar y volver al inicio de sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
