import 'package:dio/dio.dart';
import 'package:receipe_app/core/constants/constant.dart';
import 'package:receipe_app/features/categories/data/models/categories_model.dart';
import 'package:retrofit/retrofit.dart';

part 'categories_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class CategoriesApiService {
  factory CategoriesApiService(Dio dio) = _CategoriesApiService;

 @GET('categories.php')
  Future<HttpResponse<CategoryModel>> fetchCategories();
}