import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:receipe_app/core/resources/data_state.dart';
import 'package:receipe_app/features/meals/data/models/meal_details_model.dart';
import 'package:receipe_app/features/meals/domain/usecases/meal_details_usecase.dart';
import 'package:receipe_app/features/meals/domain/usecases/meals_list_usecase.dart';
part 'meal_details_state.dart';

class MealDetailsCubit extends Cubit<MealDetailsState> {
  final MealDetailsUseCase _mealDetailsUseCase;

  MealDetailsCubit(this._mealDetailsUseCase) : super(MealDetailsInitial());

  void getMealsById(String id) async {
    emit(MealDetailsLoading());

    final dataState = await _mealDetailsUseCase(params:id);

    if (dataState is DataSuccess && dataState.data!.meals.isNotEmpty) {
      emit(MealDetailsLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(MealDetailsError(dataState.error));
    }
  }

}
