import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:receipe_app/core/resources/data_state.dart';
import 'package:receipe_app/features/meals/data/models/meal_model.dart';
import 'package:receipe_app/features/meals/domain/usecases/meal_details_usecase.dart';
import 'package:receipe_app/features/meals/domain/usecases/meals_list_usecase.dart';
part 'meals_state.dart';

class MealsCubit extends Cubit<MealState> {
  final MealsListUseCase _MealsListUseCase;

  MealsCubit(this._MealsListUseCase) : super(MealsInitial());

  void getMealsByCategory(String category) async {
    emit(MealsLoading());

    final dataState = await _MealsListUseCase(params:category);

    if (dataState is DataSuccess && dataState.data!.mealEntity.isNotEmpty) {
      emit(MealsLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(MealsError(dataState.error));
    }
  }

}
