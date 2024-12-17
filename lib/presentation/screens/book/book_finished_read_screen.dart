import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';

class BookFinishedReadScreen extends StatefulWidget {
  static const name = 'book-finished-read-screen';
  const BookFinishedReadScreen({super.key});

  @override
  State<BookFinishedReadScreen> createState() => _BookFinishedReadScreenState();
}

class _BookFinishedReadScreenState extends State<BookFinishedReadScreen> {
  int rate = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '¡Felicidades por completar tu lectura!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Ve al inicio y descubre más historias que te están esperando.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    5,
                    (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              rate = index + 1;
                            });
                          },
                          child: Icon(
                            index < rate ? Icons.star : Icons.star_border,
                            color: const Color(0xff906E2A),
                            size: 40,
                          ),
                        )),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  '¿Te ha gustado la historia?\n¡Tu opinión cuenta! Valórala para ayudarnos a mejorar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/home/0');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Ir al inicio',
                    style: TextStyle(
                      color: AppColors.accentColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
