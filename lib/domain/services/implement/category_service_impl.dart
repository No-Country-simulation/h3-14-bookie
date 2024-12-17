import 'package:h3_14_bookie/domain/model/category.dart';
import 'package:h3_14_bookie/domain/model/dto/category_dto.dart';
import 'package:h3_14_bookie/domain/services/category_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:h3_14_bookie/constants/collection_references.dart';

class CategoryServiceImpl implements ICategoryService {
  final db = FirebaseFirestore.instance;

  late final CollectionReference _categoryRef;

  CategoryServiceImpl() {
    _categoryRef = db
        .collection(CollectionReferences.CATEGORY_COLLECTION_REF)
        .withConverter<Category>(
            fromFirestore: (snapshots, _) =>
                Category.fromFirestore(snapshots, _),
            toFirestore: (category, _) => category.toFirestore());
  }

  @override
  Future<List<CategoryDto>> getCategories() async {
    final docs = await _categoryRef.get();
    return docs.docs.map((doc) {
      final category = (doc as DocumentSnapshot<Category>).data();
      return CategoryDto(uid: doc.id, name: category?.name ?? '');
    }).toList();
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
  Future<String> getCategoryUidByName(String categoryName) async {
    final docs =
        await _categoryRef.where('name', isEqualTo: categoryName).get();
    if (docs.docs.isEmpty) {
      return await createCategory(categoryName);
    }
    return docs.docs.first.id;
  }

  @override
  Future<String> createCategory(String categoryName) async {
    Category category = Category(name: categoryName);
    final docRef = await _categoryRef.add(category);
    final docSnap = await docRef.get() as DocumentSnapshot<Category>;
    return docSnap.id;
  }
}
