import 'package:flutter/material.dart';
import 'package:h3_14_bookie/config/theme/app_colors.dart';
import 'package:h3_14_bookie/presentation/screens/login/login.dart';
import 'package:h3_14_bookie/presentation/screens/signup/signup.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});
  static const String name = 'InitScreen';

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  late Image _backgroundImage;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _backgroundImage = Image.asset('assets/images/back_img.png');
    _backgroundImage.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((info, synchronousCall) {
        if (mounted) {
          setState(() {
            _isLoaded = true;
          });
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back_img.png'),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _backgroundImage.image,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 115),
                Image.asset(
                  'assets/images/Iconos-png/BOOKIE.png',
                  height: 100,
                ),
                const Spacer(flex: 2),
                _socialButtons(),
                const SizedBox(height: 16),
                _divider(),
                const SizedBox(height: 16),
                _loginButton(context),
                const SizedBox(height: 16),
                _registerButton(context),
                const SizedBox(height: 16),
                _termsAndConditions(),
                const SizedBox(height: 32),
              ],
            ),
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
          Expanded(child: Divider(color: Colors.grey.shade200, thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'O',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey.shade200, thickness: 1)),
        ],
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF006494),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 47),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      },
      child: const Text(
        'Iniciar sesión',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF006494),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 47),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Signup()),
        );
      },
      child: const Text(
        'Registrarme',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _termsAndConditions() {
    return const Text(
      'Al registrarte, aceptas nuestros Términos de uso y Política de Privacidad',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    );
  }
}
