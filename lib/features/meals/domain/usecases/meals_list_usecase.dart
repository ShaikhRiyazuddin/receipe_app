
import 'package:receipe_app/core/resources/data_state.dart';
import 'package:receipe_app/core/usecases/usecases.dart';
import 'package:receipe_app/features/categories/data/models/categories_model.dart';
import 'package:receipe_app/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:receipe_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:receipe_app/features/meals/data/models/meal_model.dart';
import 'package:receipe_app/features/meals/domain/repositories/meals_repository.dart';

class MealsListUseCase
    implements UseCase<DataState<MealModel>, String> {
  final MealsRepository _mealsRepository;

  MealsListUseCase(this._mealsRepository);

  @override
  Future<DataState<MealModel>> call({String? params}) {
    return _mealsRepository.fetchMealByCategory(params!);
  }
}