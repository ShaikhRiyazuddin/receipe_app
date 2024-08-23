

import 'package:receipe_app/features/meals/domain/entities/meal_details_entity.dart';
import 'package:receipe_app/features/meals/domain/entities/meal_entity.dart';

class MealDetailsModel {
    List<MealDetailEntity> meals;

    MealDetailsModel({
        required this.meals,
    });

    factory MealDetailsModel.fromJson(Map<String, dynamic> json) => MealDetailsModel(
        meals: List<MealDetailEntity>.from(json["meals"].map((x) => MealDetailEntity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
    };
}