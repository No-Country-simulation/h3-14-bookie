import 'package:flutter/material.dart';
import 'package:h3_14_bookie/domain/model/app_user.dart';
import 'package:h3_14_bookie/domain/model/dto/user_dto.dart';
import 'package:h3_14_bookie/domain/model/reading.dart';
import 'package:h3_14_bookie/domain/model/writing.dart';
import 'package:h3_14_bookie/domain/services/app_user_service.dart';
import 'package:h3_14_bookie/domain/services/auth_service.dart';
import 'package:h3_14_bookie/domain/services/firebase_service.dart';
import 'package:h3_14_bookie/domain/services/implement/app_user_service_impl.dart';

import 'package:h3_14_bookie/presentation/widgets/dialogs/error_dialog.dart';
import 'package:h3_14_bookie/presentation/widgets/getStructure/get%20structure.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 100),
        const Center(
          child: Text('Favorites View'),
        ),
        const SizedBox(height: 50),
        _Button(context),
        _Button2(context),
        _ButtonDialog(context),
        _logoutButton(context),
        _GetStructure(context),
      ],
    );
  }
}

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

Widget _Button(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
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
          final newUser = UserDto(
            name: 'Pepito TODO',
            email: 'pepito@gmail.com',
            role: 'lector',
          );
          IAppUserService appUserServiceImpl = AppUserServiceImpl();
          await appUserServiceImpl.createAppUser(newUser);
        },
        child: const Text(
          "crear",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

Widget _Button2(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
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
          final newUser = UserDto(
            name: 'Pepito TODO',
            email: 'pepito@gmail.com',
            role: 'lector',
          );
          IAppUserService appUserServiceImpl = AppUserServiceImpl();
          await appUserServiceImpl.createAppUser(newUser);
        },
        child: const Text(
          "Actualizar datos",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

Widget _ButtonDialog(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
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
          ErrorDialog.show(context);
        },
        child: const Text(
          "Show Dialog",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

Widget _GetStructure(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FirestoreSchemaExporter()));
        },
        child: const Text(
          "Get Structure",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}
