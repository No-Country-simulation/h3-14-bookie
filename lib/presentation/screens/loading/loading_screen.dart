import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});
  static const String name = 'loading-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/Iconos-png/Illustration_reading.png',
                height: 250,
              ),
              const SizedBox(height: 40),
              Text(
                'Ingresando',
                style: GoogleFonts.inter(
                  fontSize: 40,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const CircularProgressIndicator(
                color: Color(0xFF006494),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
