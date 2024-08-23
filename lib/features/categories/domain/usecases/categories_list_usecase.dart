
import 'package:receipe_app/core/resources/data_state.dart';
import 'package:receipe_app/core/usecases/usecases.dart';
import 'package:receipe_app/features/categories/data/models/categories_model.dart';
import 'package:receipe_app/features/categories/domain/repositories/categories_repository.dart';

class CategoriesListUseCase
    implements UseCase<DataState<CategoryModel>, String> {
  final CategoriesRepository _categoriesRepository;

  CategoriesListUseCase(this._categoriesRepository);

  @override
  Future<DataState<CategoryModel>> call({String? params}) {
    return _categoriesRepository.fetchCategories();
  }
}