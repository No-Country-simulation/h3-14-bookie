import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: "Configuración de la aplicación"),
            ConfigOption(title: "Perfil y configuración de la cuenta"),
            ConfigOption(title: "Notificaciones"),
            ConfigOption(title: "Preferencias de lectura"),
            ConfigOption(title: "Modo nocturno", subtitle: "Desactivado"),
            SizedBox(height: 16.0),
            SectionHeader(title: "Privacidad y Seguridad"),
            ConfigOption(title: "Cuentas silenciadas"),
            ConfigOption(title: "Cuentas bloqueadas"),
            ConfigOption(title: "Preferencias de contenido"),
            SizedBox(height: 16.0),
            SectionHeader(title: "Más información y asistencia"),
            ConfigOption(title: "Sobre Bookie"),
            ConfigOption(title: "Ayuda & Soporte"),
            ConfigOption(title: "Políticas de privacidad"),
            ConfigOption(title: "Condiciones de uso"),
            SizedBox(height: 16.0),
            SectionHeader(title: "Inicio de Sesión"),
            ConfigOption(title: "Agregar cuenta"),
            ConfigOption(title: "Cerrar Sesión"),
            ConfigOption(title: "Salir de todas las cuentas"),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ConfigOption extends StatelessWidget {
  final String title;
  final String? subtitle;

  const ConfigOption({required this.title, this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              title,
              style: const TextStyle(fontSize: 17.0),
            ),
            subtitle: subtitle != null
                ? Text(
                    subtitle!,
                    style: const TextStyle(fontSize: 15.0, color: Colors.grey),
                  )
                : null,
            onTap: () {
              // Acción al seleccionar esta opción
            },
          ),
          const Divider(height: 1, color: Colors.grey),
        ],
      ),
    );
  }
}
