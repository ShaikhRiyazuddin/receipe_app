import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:receipe_app/core/resources/data_state.dart';
import 'package:receipe_app/features/categories/data/models/categories_model.dart';
import 'package:receipe_app/features/categories/domain/usecases/categories_list_usecase.dart';
part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesListUseCase _categoriesListUseCase;

  CategoriesCubit(this._categoriesListUseCase) : super(CategoriesInitial());

  void getCategoriess(List<String> ingredients) async {
    emit(CategoriesLoading());

    final dataState = await _categoriesListUseCase();

    if (dataState is DataSuccess && dataState.data!.categories.isNotEmpty) {
      emit(CategoriesLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(CategoriesError(dataState.error));
    }
  }

}
