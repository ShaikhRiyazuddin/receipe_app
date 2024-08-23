
import 'package:receipe_app/features/categories/domain/entities/categories_entity.dart';

class CategoryModel  {
    List<CategoryEntity> categories;

    CategoryModel({
        required this.categories,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: List<CategoryEntity>.from(json["categories"].map((x) => CategoryEntity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}