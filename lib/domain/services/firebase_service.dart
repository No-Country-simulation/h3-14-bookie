import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h3_14_bookie/domain/model/app_user.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
final String _collectionName = 'users10';

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

Future<void> addUserData() async {
  try {
    // Datos a enviar
    Map<String, dynamic> userData = {
      "name": "Juan Perez",
      "email": "juan.perez@example.com",
      "address": "Calle Falsa 123, Ciudad, País",
      "age": 30,
    };

    // Crear el documento dentro de la colección "userData"
    await db.collection("userData").add(userData);
    print("Datos guardados correctamente.");
  } catch (e) {
    print("Error al guardar los datos: $e");
  }
}

Future<void> createUser(AppUser user) async {
  try {
    await db
        .collection(_collectionName)
        .doc(user.email) // Usando el email como ID del documento
        .withConverter(
          fromFirestore: AppUser.fromFirestore,
          toFirestore: (AppUser user, _) => user.toFirestore(),
        )
        .set(user);
  } catch (e) {
    throw Exception('Error al crear usuario: $e');
  }
}
