import 'package:flutter/foundation.dart';

class CategoryModel {
  String id;
  String imageName;
  String name;

  CategoryModel({
    required this.id,
    required this.imageName,
    required this.name,
  });

  static List<CategoryModel> categories = [
    CategoryModel(id: 'general', imageName: 'general', name: 'general'),
    CategoryModel(id: 'business', imageName: 'business', name: 'business'),
    CategoryModel(id: 'sports', imageName: 'sport', name: 'sport'),
    CategoryModel(
      id: 'entertainment',
      imageName: 'entertain',
      name: 'Entertainment',
    ),
    CategoryModel(id: 'health', imageName: 'health', name: 'health'),
    CategoryModel(id: 'technology', imageName: 'tech', name: 'technology'),
    CategoryModel(id: 'science', imageName: 'science', name: 'science'),
  ];
}
