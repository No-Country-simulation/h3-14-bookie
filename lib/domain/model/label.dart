import 'package:cloud_firestore/cloud_firestore.dart';

class Label {
  final String? name;

  Label({this.name});

  // Método para crear una instancia desde un DocumentSnapshot (Firestore)
  factory Label.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Label(
      name: data?['name'],
    );
  }

  // Método para crear una instancia desde un Map
  factory Label.fromMap(Map<String, dynamic> map) {
    return Label(
      name: map['name'] as String?,
    );
  }

  // Método para convertir una instancia en un Map compatible con Firestore
  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
    };
  }

  // Método adicional para convertir una instancia en un Map genérico
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
