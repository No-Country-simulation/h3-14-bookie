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
  String createCategory(String categoryName) {
    Category category = Category(name: categoryName);
    _categoryRef.add(category);

    return 'created';
  }
}
