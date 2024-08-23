import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:receipe_app/core/resources/data_state.dart';
import 'package:receipe_app/features/meals/data/models/meal_details_model.dart';
import 'package:receipe_app/features/meals/domain/usecases/search_meals_usecase.dart';
part 'search_meals_state.dart';

class SearchMealsCubit extends Cubit<SearchMealsState> {
  final SearchMealsUseCase _SearchMealsListUseCase;

  SearchMealsCubit(this._SearchMealsListUseCase) : super(SearchMealsInitial());

  void getSearchMeals(String ingredients) async {
    emit(SearchMealsLoading());

    final dataState = await _SearchMealsListUseCase(params: ingredients);

    if (dataState is DataSuccess && dataState.data!.meals.isNotEmpty) {
      emit(SearchMealsLoaded(dataState.data!));
    }else{
      emit(SearchMealsEmpty());
    }

    if (dataState is DataFailed) {
      emit(SearchMealsError(dataState.error));
    }
  }

}
