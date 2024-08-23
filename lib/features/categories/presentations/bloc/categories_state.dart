
part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  final CategoryModel? categories;
  final DioException? error;

  const CategoriesState({this.categories, this.error});

  @override
  List<Object?> get props => [categories, error];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  const CategoriesLoaded(CategoryModel? categories) : super(categories: categories);
}

class CategoriesError extends CategoriesState {
  const CategoriesError(DioException? error) : super(error: error);
}