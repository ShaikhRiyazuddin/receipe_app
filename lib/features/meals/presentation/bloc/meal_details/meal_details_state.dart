
part of 'meal_details_cubit.dart';

abstract class MealDetailsState extends Equatable {
  final MealDetailsModel? mealModel;
  final DioException? error;

  const MealDetailsState({this.mealModel, this.error});

  @override
  List<Object?> get props => [mealModel, error];
}

class MealDetailsInitial extends MealDetailsState {}

class MealDetailsLoading extends MealDetailsState {}

class MealDetailsLoaded extends MealDetailsState {
  const MealDetailsLoaded(MealDetailsModel? mealModel) : super(mealModel: mealModel);
}

class MealDetailsError extends MealDetailsState {
  const MealDetailsError(DioException? error) : super(error: error);
}