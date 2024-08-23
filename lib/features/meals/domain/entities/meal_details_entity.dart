import 'dart:convert';

class MealDetailEntity {
  String idMeal;
  String strMeal;
  dynamic strDrinkAlternate;
  String strCategory;
  String strArea;
  String strInstructions;
  String strMealThumb;
  String strTags;
  String strYoutube;
  dynamic strSource;
  dynamic strImageSource;
  dynamic strCreativeCommonsConfirmed;
  dynamic dateModified;
  List<Ingredients> ingredients;

  MealDetailEntity(
      {required this.idMeal,
      required this.strMeal,
      required this.strDrinkAlternate,
      required this.strCategory,
      required this.strArea,
      required this.strInstructions,
      required this.strMealThumb,
      required this.strTags,
      required this.strYoutube,
      required this.strSource,
      required this.strImageSource,
      required this.strCreativeCommonsConfirmed,
      required this.dateModified,
      required this.ingredients});

  factory MealDetailEntity.fromJson(Map<String, dynamic> json) =>
      MealDetailEntity(
          idMeal: json["idMeal"],
          strMeal: json["strMeal"],
          strDrinkAlternate: json["strDrinkAlternate"]??'',
          strCategory: json["strCategory"]??'',
          strArea: json["strArea"]??'',
          strInstructions: json["strInstructions"]??'',
          strMealThumb: json["strMealThumb"],
          strTags: json["strTags"]??'',
          strYoutube: json["strYoutube"]??'',
          strSource: json["strSource"]??'',
          strImageSource: json["strImageSource"]??'',
          strCreativeCommonsConfirmed: json["strCreativeCommonsConfirmed"]??'',
          dateModified: json["dateModified"]??'',
          ingredients: List.generate(
              19,
              (index) => Ingredients(
                  ingredient: json["strIngredient${index + 1}"] ?? '',
                  measure: json["strMeasure${index + 1}"] ?? '')));

  Map<String, dynamic> toJson() => {
        "idMeal": idMeal,
        "strMeal": strMeal,
        "strDrinkAlternate": strDrinkAlternate,
        "strCategory": strCategory,
        "strArea": strArea,
        "strInstructions": strInstructions,
        "strMealThumb": strMealThumb,
        "strTags": strTags,
        "strYoutube": strYoutube,
        "strSource": strSource,
        "strImageSource": strImageSource,
        "strCreativeCommonsConfirmed": strCreativeCommonsConfirmed,
        "dateModified": dateModified,
      };
}

class Ingredients {
  final String ingredient;
  final String measure;

  Ingredients({required this.ingredient, required this.measure});
}
