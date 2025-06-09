import 'package:flutter/foundation.dart';

class CategoryModel {
  String id;
  String imageName;

  CategoryModel({required this.id, required this.imageName});

  static List<CategoryModel> categories = [
    CategoryModel(id: 'id', imageName: 'general'),
    CategoryModel(id: 'id', imageName: 'business'),
    CategoryModel(id: 'id', imageName: 'sport'),
    CategoryModel(id: 'id', imageName: 'entertain'),
    CategoryModel(id: 'id', imageName: 'health'),
    CategoryModel(id: 'id', imageName: 'tech'),
    CategoryModel(id: 'id', imageName: 'science'),
  ];
}
