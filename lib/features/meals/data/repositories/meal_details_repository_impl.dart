import 'dart:io';

import 'package:dio/dio.dart';
import 'package:receipe_app/core/resources/data_state.dart';
import 'package:receipe_app/features/categories/data/data_sources/categories_api_service.dart';
import 'package:receipe_app/features/meals/data/data_sources/meal_api_service.dart';
import 'package:receipe_app/features/categories/data/models/categories_model.dart';
import 'package:receipe_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:receipe_app/features/meals/domain/repositories/meals_repository.dart';
import 'package:receipe_app/features/meals/data/models/meal_details_model.dart';
import 'package:receipe_app/features/meals/data/models/meal_model.dart';

class MealsRepositoryImpl implements MealsRepository {
  final MealApiService _mealApiService;

  MealsRepositoryImpl(this._mealApiService);

  @override
  Future<DataState<MealModel>> fetchMealByCategory(String category) async {
    try {
      final httpResponse = await _mealApiService.fetchMealByCategory(category);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<MealDetailsModel>> fetchMealDetailsById(String id) async {
    try {
      final httpResponse = await _mealApiService.fetchMealDetailsById(id);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<MealDetailsModel>> fetchSearchMeal(String text) async {
    try {
      final httpResponse = await _mealApiService.fetchSearchMeal(text);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
