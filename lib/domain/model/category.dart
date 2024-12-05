import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String? name;

  Category({this.name});

  factory Category.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Category(
      name: data?['name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
    };
  }
}
