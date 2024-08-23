
part of 'meals_cubit.dart';

abstract class MealState extends Equatable {
  final MealModel? mealModel;
  final DioException? error;

  const MealState({this.mealModel, this.error});

  @override
  List<Object?> get props => [mealModel, error];
}

class MealsInitial extends MealState {}

class MealsLoading extends MealState {}

class MealsLoaded extends MealState {
  const MealsLoaded(MealModel? mealModel) : super(mealModel: mealModel);
}

class MealsError extends MealState {
  const MealsError(DioException? error) : super(error: error);
}