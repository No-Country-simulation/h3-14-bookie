import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUsers() async {
  List users = [];
  CollectionReference usersRef = db.collection('users');

  QuerySnapshot queryUsers = await usersRef.get();

  for (var documento in queryUsers.docs) {
    users.add(documento.data);
  }

  return users;
}
