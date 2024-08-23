import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:receipe_app/features/categories/data/data_sources/categories_api_service.dart';
import 'package:receipe_app/features/meals/data/data_sources/meal_api_service.dart';
import 'package:receipe_app/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:receipe_app/features/meals/data/repositories/meal_details_repository_impl.dart';
import 'package:receipe_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:receipe_app/features/meals/domain/repositories/meals_repository.dart';
import 'package:receipe_app/features/categories/domain/usecases/categories_list_usecase.dart';
import 'package:receipe_app/features/meals/domain/usecases/meal_details_usecase.dart';
import 'package:receipe_app/features/meals/domain/usecases/meals_list_usecase.dart';
import 'package:receipe_app/features/categories/presentations/bloc/categories_cubit.dart';
import 'package:receipe_app/features/meals/domain/usecases/search_meals_usecase.dart';
import 'package:receipe_app/features/meals/presentation/bloc/meal_details/meal_details_cubit.dart';
import 'package:receipe_app/features/meals/presentation/bloc/meals/meals_cubit.dart';
import 'package:receipe_app/features/meals/presentation/bloc/search/search_meals_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<CategoriesApiService>(CategoriesApiService(sl()));
  sl.registerSingleton<MealApiService>(MealApiService(sl()));

  sl.registerSingleton<CategoriesRepository>(
      CategoriesRepositoryImpl(sl()));
  sl.registerSingleton<MealsRepository>(
      MealsRepositoryImpl(sl()));

  sl.registerFactory<CategoriesCubit>(() => CategoriesCubit(sl()));
  sl.registerFactory<MealsCubit>(() => MealsCubit(sl()));
  sl.registerFactory<MealDetailsCubit>(() => MealDetailsCubit(sl()));
  sl.registerFactory<SearchMealsCubit>(() => SearchMealsCubit(sl()));

  sl.registerSingleton(CategoriesListUseCase(sl()));
  sl.registerSingleton(MealsListUseCase(sl()));
  sl.registerSingleton(MealDetailsUseCase(sl()));
  sl.registerSingleton(SearchMealsUseCase(sl()));

  // sl.registerSingleton<RecipeApiService>(RecipeApiService(sl()));
  // sl.registerSingleton<RecipeRepository>(RecipeRepositoryImpl(sl()));
  // sl.registerFactory<RecipeCubit>(() => RecipeCubit(sl()));
  // sl.registerSingleton(GetRecipesUseCase(sl()));
}
