import 'dart:io';

import 'package:dio/dio.dart';
import 'package:receipe_app/core/resources/data_state.dart';
import 'package:receipe_app/features/categories/data/data_sources/categories_api_service.dart';
import 'package:receipe_app/features/categories/data/models/categories_model.dart';
import 'package:receipe_app/features/categories/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesApiService _categoriesApiService;

  CategoriesRepositoryImpl(this._categoriesApiService);

  @override
  Future<DataState<CategoryModel>> fetchCategories() async {
    try {
      final httpResponse = await _categoriesApiService.fetchCategories();

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
