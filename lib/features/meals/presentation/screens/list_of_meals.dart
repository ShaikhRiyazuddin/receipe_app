import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receipe_app/core/widget/utils.dart';
import 'package:receipe_app/features/categories/domain/entities/categories_entity.dart';
import 'package:receipe_app/features/meals/presentation/bloc/meals/meals_cubit.dart';

class ListOfMeals extends StatefulWidget {
  final CategoryEntity categoryEntity;
  const ListOfMeals({super.key, required this.categoryEntity});

  @override
  State<ListOfMeals> createState() => _ListOfMealsState();
}

class _ListOfMealsState extends State<ListOfMeals> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context
        .read<MealsCubit>()
        .getMealsByCategory(widget.categoryEntity.strCategory));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryEntity.strCategory),
      ),
      body: Column(
        children: [
          HeaderWithImage(
              name: widget.categoryEntity.strCategory,
              img: widget.categoryEntity.strCategoryThumb,
              height: height),
          BlocConsumer<MealsCubit, MealState>(
              listener: (context, state) {},
              builder: (BuildContext context, state) {
                if (state is MealsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is MealsError) {
                  return Center(
                    child: Text(state.error!.message!),
                  );
                }
                if (state is MealsLoaded) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 280,
                    child: ListView.builder(
                      itemCount: state.mealModel!.mealEntity.length,
                      itemBuilder: (context, index) {
                        var _meal = state.mealModel!.mealEntity[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/MealDetails',
                            arguments: _meal);
                          },
                          child: ListItem(
                            size: size,
                            image: _meal.strMealThumb,
                            name: _meal.strMeal,
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container();
              }),
        ],
      ),
    );
  }
}
