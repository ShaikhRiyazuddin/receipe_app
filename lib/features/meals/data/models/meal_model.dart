
import 'package:receipe_app/features/categories/domain/entities/categories_entity.dart';
import 'package:receipe_app/features/meals/domain/entities/meal_entity.dart';

class MealModel  {
    List<MealEntity> mealEntity;

    MealModel({
        required this.mealEntity,
    });

    factory MealModel.fromJson(Map<String, dynamic> json) => MealModel(
        mealEntity: List<MealEntity>.from(json["meals"].map((x) => MealEntity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mealEntity": List<dynamic>.from(mealEntity.map((x) => x.toJson())),
    };
}