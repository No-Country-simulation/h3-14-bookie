import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:h3_14_bookie/domain/services/category_service.dart';
import 'package:h3_14_bookie/domain/services/implement/category_service_impl.dart';

Future<void> main(List<String> args) async {
  await Firebase.initializeApp();
  final ICategoryService categoryService = CategoryServiceImpl();

  print('');
}
