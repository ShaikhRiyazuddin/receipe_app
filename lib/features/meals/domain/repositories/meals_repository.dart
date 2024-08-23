
import 'package:receipe_app/core/resources/data_state.dart';
import 'package:receipe_app/features/categories/data/models/categories_model.dart';
import 'package:receipe_app/features/meals/data/models/meal_details_model.dart';
import 'package:receipe_app/features/meals/data/models/meal_model.dart';

abstract class MealsRepository {
  Future<DataState<MealModel>> fetchMealByCategory(String category);
  Future<DataState<MealDetailsModel>> fetchMealDetailsById(String id);
  Future<DataState<MealDetailsModel>> fetchSearchMeal(String text);
}