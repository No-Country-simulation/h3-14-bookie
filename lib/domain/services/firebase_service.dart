import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
//. Leer base  de datos
Future<List<Map<String, dynamic>>> getUsers() async {
  List<Map<String, dynamic>> users = [];
  CollectionReference usersRef = db.collection('users');

  QuerySnapshot queryUsers = await usersRef.get();

//.Se comento este codigo ya qu eno proporcionaba el UID del usuario, el cual se necesita para actializar la info del usuario
  // queryUsers.docs.forEach((documento) {
  //   users.add(documento.data() as Map<String, dynamic>);
  // });
  for (var doc in queryUsers.docs) {
    Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
    userData['uid'] = doc.id; // Agregar el UID al mapa
    users.add(userData);
  }
  print({"users": users});
  return users;
}

//. Agregar nuevos usuarios
Future<void> addUser(
    String email, String name, String password, String userName) async {
  await db.collection('users').add({
    "email": email,
    "name": name,
    "password": password,
    "userName": userName
  });
}
