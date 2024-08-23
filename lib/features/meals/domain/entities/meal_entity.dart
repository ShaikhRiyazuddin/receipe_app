
import 'package:hive/hive.dart';
part 'meal_entity.g.dart';

@HiveType(typeId: 0)
class MealEntity {
   @HiveField(0)
    String strMeal;
     @HiveField(1)
    String strMealThumb;
     @HiveField(2)
    String idMeal;

    MealEntity({
        required this.strMeal,
        required this.strMealThumb,
        required this.idMeal,
    });

    factory MealEntity.fromJson(Map<String, dynamic> json) => MealEntity(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
    );

    Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
    };
}