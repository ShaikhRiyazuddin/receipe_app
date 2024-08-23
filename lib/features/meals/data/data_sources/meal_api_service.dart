import 'package:dio/dio.dart';
import 'package:receipe_app/core/constants/constant.dart';
import 'package:receipe_app/features/meals/data/models/meal_details_model.dart';
import 'package:receipe_app/features/meals/data/models/meal_model.dart';
import 'package:retrofit/retrofit.dart';

part 'meal_api_service.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class MealApiService {
  factory MealApiService(Dio dio) = _MealApiService;

 @GET('filter.php?c={categories}')
  Future<HttpResponse<MealModel>> fetchMealByCategory(@Path("categories") categories);

 @GET('lookup.php?i={id}')
  Future<HttpResponse<MealDetailsModel>> fetchMealDetailsById(@Path("id") id);

 @GET('search.php?s={text}')
  Future<HttpResponse<MealDetailsModel>> fetchSearchMeal(@Path("text") text);

}