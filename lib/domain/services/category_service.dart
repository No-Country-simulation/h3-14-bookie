import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h3_14_bookie/domain/model/category.dart';

interface class ICategoryService {
  Stream<QuerySnapshot> getCategories() {
    return Stream.empty();
  }

  Future<Category> getCategoryByUid(String uid) async {
    return Future(() => Category(name: 'Default Category'));
  }

  Future<String> createCategory(String categoryName) async {
    return '';
  }
}
