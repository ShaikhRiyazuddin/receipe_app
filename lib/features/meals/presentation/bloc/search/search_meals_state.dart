
part of 'search_meals_cubit.dart';

abstract class SearchMealsState extends Equatable {
  final MealDetailsModel? mealModel;
  final DioException? error;

  const SearchMealsState({this.mealModel, this.error});

  @override
  List<Object?> get props => [mealModel, error];
}

class SearchMealsInitial extends SearchMealsState {}

class SearchMealsLoading extends SearchMealsState {}
class SearchMealsEmpty extends SearchMealsState {}

class SearchMealsLoaded extends SearchMealsState {
  const SearchMealsLoaded(MealDetailsModel? mealModel) : super(mealModel: mealModel);
}

class SearchMealsError extends SearchMealsState {
  const SearchMealsError(DioException? error) : super(error: error);
}