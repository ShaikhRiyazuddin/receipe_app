import 'package:flutter/material.dart';
import 'package:receipe_app/features/categories/domain/entities/categories_entity.dart';
import 'package:receipe_app/features/meals/domain/entities/meal_entity.dart';
import 'package:receipe_app/features/meals/presentation/screens/list_of_meals.dart';
import 'package:receipe_app/features/categories/presentations/screens/categories_screen.dart';
import 'package:receipe_app/features/meals/presentation/screens/meals_details.dart';
// import 'package:recipe_finder/features/ingredients/presentations/screens/pantry_screen.dart';
// import 'package:recipe_finder/features/ingredients/presentations/screens/search_ingredients.dart';
// import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';
// import 'package:recipe_finder/features/recipes/presentation/screens/recipe_details_screen.dart';
// import 'package:recipe_finder/features/recipes/presentation/screens/recipe_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(CategoriesScreen());

      case '/ListOfMeals':
        return _materialRoute(ListOfMeals(categoryEntity: settings.arguments as CategoryEntity,));

      case '/MealDetails':
        return _materialRoute(
            MealsDetails(mealEntity: settings.arguments as MealEntity));

      // case '/SearchIngredient':
      //   return _materialRoute(SearchIngredients());

      default:
        return _materialRoute(CategoriesScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}