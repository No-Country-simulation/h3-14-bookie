import 'package:h3_14_bookie/domain/model/category.dart';
import 'package:h3_14_bookie/domain/services/category_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String CATEGORY_COLLECTION_REF = "categories";

class CategoryServiceImpl implements ICategoryService {
  final db = FirebaseFirestore.instance;

  late final CollectionReference _categoryRef;

  CategoryServiceImpl() {
    _categoryRef = db
        .collection(CATEGORY_COLLECTION_REF)
        .withConverter<Category>(
            fromFirestore: (snapshots, _) =>
                Category.fromFirestore(snapshots, _),
            toFirestore: (category, _) => category.toFirestore());
  }

  @override
  Stream<QuerySnapshot<Object?>> getCategories() {
    return _categoryRef.snapshots();
  }

  @override
  Future<Category> getCategoryByUid(String uid) async {
    final docSnap = await _categoryRef.doc(uid).get();
    if (!docSnap.exists) {
      throw Exception('Category not found');
    }
    return (docSnap as DocumentSnapshot<Category>).data()!;
  }

  @override
  Future<String> createCategory(String categoryName) async {
    Category category = Category(name: categoryName);
    final docRef = await _categoryRef.add(category);
    final docSnap = await docRef.get() as DocumentSnapshot<Category>;
    return docSnap.id;
  }
}
