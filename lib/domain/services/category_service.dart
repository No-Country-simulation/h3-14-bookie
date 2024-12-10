import 'package:h3_14_bookie/domain/model/category.dart';
import 'package:h3_14_bookie/domain/model/dto/category_dto.dart';

interface class ICategoryService {
  Future<List<CategoryDto>> getCategories() {
    return Future.value([]);
  }

  Future<Category> getCategoryByUid(String uid) async {
    return Future(() => Category(name: 'Default Category'));
  }

  Future<String> getCategoryUidByName(String categoryName) async {
    return '';
  }

  Future<String> createCategory(String categoryName) async {
    return '';
  }
}
