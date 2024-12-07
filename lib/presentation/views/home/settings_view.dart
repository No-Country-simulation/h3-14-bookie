import 'package:flutter/material.dart';
import 'package:h3_14_bookie/domain/services/auth_service.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        shadowColor: Colors.black.withOpacity(0.1),
        title: const Text(
          "Configuración",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40.0),
            const SectionHeader1(title: "Configuración de la aplicación"),
            const SizedBox(height: 30.0),
            const SectionHeader2(title: "Perfil y configuración de la cuenta"),
            const DividerStyled(),
            const SizedBox(height: 20.0),
            const SectionHeader2(title: "Notificaciones"),
            const DividerStyled(),
            const SizedBox(height: 20.0),
            const SectionHeader2(title: "Preferencias de lectura"),
            const DividerStyled(),
            const SizedBox(height: 20.0),
            const SectionHeader2(
              title: "Modo nocturno",
              subtitle: "Desactivado",
            ),
            const DividerStyled(),
            const SizedBox(height: 40.0),
            const SectionHeader1(title: "Privacidad y Seguridad"),
            const SizedBox(height: 30.0),
            const SectionHeader2(title: "Cuentas silenciadas"),
            const DividerStyled(),
            const SizedBox(height: 20.0),
            const SectionHeader2(title: "Cuentas bloqueadas"),
            const DividerStyled(),
            const SizedBox(height: 20.0),
            const SectionHeader2(title: "Preferencias de contenido"),
            const DividerStyled(),
            const SizedBox(height: 40.0),
            const SectionHeader1(title: "Más información y asistencia"),
            const SizedBox(height: 30.0),
            const SectionHeader2(title: "Sobre Bookie"),
            const DividerStyled(),
            const SizedBox(height: 20.0),
            const SectionHeader2(title: "Ayuda & Soporte"),
            const DividerStyled(),
            const SizedBox(height: 20.0),
            const SectionHeader2(title: "Políticas de privacidad"),
            const DividerStyled(),
            const SizedBox(height: 20.0),
            const SectionHeader2(title: "Condiciones de uso"),
            const DividerStyled(),
            const SizedBox(height: 40.0),
            const SectionHeader1(title: "Inicio de Sesión"),
            const SizedBox(height: 30.0),
            const SectionHeader3(title: "Agregar cuenta"),
            const SizedBox(height: 20.0),
            SectionHeader3(title: "Cerrar sesión", onTap: () async {
              await AuthService().signout(context: context);
            },),
            const SizedBox(height: 20.0),
            const SectionHeader3(title: "Salir de todas las cuentas"),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class SectionHeader1 extends StatelessWidget {
  final String title;

  const SectionHeader1({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class SectionHeader2 extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeader2({required this.title, this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontFamily: 'Roboto',
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                fontFamily: 'Roboto',
              ),
            )
          : null,
    );
  }
}

class SectionHeader3 extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const SectionHeader3({required this.title, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}

class DividerStyled extends StatelessWidget {
  const DividerStyled({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1.0,
      color: Color(0xFFDADADA),
      indent: 0,
      endIndent: 0,
    );
  }
}
