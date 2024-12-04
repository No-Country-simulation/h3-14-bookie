import 'package:cloud_firestore/cloud_firestore.dart';

class Label {
  final String? name;

  Label({this.name});

  factory Label.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Label(
      name: data?['name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
    };
  }
}
