import 'package:flutter/material.dart';
import 'package:h3_14_bookie/domain/services/auth_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _logoutButton(BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '¿Deseas cerrar sesión?',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006494),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(double.infinity, 56),
              elevation: 0,
            ),
            onPressed: () async {
              await AuthService().signout(context: context);
            },
            child: const Text(
              "Cerrar sesión",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        const Center(
          child: Text('Home View'),
        ),
        _logoutButton(context),
      ],
    );
  }
}
