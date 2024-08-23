
import 'package:receipe_app/core/resources/data_state.dart';
import 'package:receipe_app/features/categories/data/models/categories_model.dart';

abstract class CategoriesRepository {
  Future<DataState<CategoryModel>> fetchCategories();
}