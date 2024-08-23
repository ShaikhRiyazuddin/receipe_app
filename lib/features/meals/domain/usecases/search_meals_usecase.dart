
import 'package:receipe_app/core/resources/data_state.dart';
import 'package:receipe_app/core/usecases/usecases.dart';
import 'package:receipe_app/features/categories/data/models/categories_model.dart';
import 'package:receipe_app/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:receipe_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:receipe_app/features/meals/data/models/meal_details_model.dart';
import 'package:receipe_app/features/meals/domain/repositories/meals_repository.dart';

class SearchMealsUseCase
    implements UseCase<DataState<MealDetailsModel>, String> {
  final MealsRepository _mealsRepository;

  SearchMealsUseCase(this._mealsRepository);

  @override
  Future<DataState<MealDetailsModel>> call({String? params}) {
    return _mealsRepository.fetchSearchMeal(params!);
  }
}