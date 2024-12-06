import 'package:cloud_firestore/cloud_firestore.dart';

interface class ICategoryService {
  Stream<QuerySnapshot> getCategories() {
    return Stream.empty();
  }

  String createCategory(String categoryName) {
    return '';
  }
}
