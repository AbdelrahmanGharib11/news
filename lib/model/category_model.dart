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
    CategoryModel(id: 'id', imageName: 'general', name: 'general'),
    CategoryModel(id: 'id', imageName: 'business', name: 'business'),
    CategoryModel(id: 'id', imageName: 'sport', name: 'sport'),
    CategoryModel(id: 'id', imageName: 'entertain', name: 'Entertainment'),
    CategoryModel(id: 'id', imageName: 'health', name: 'health'),
    CategoryModel(id: 'id', imageName: 'tech', name: 'technology'),
    CategoryModel(id: 'id', imageName: 'science', name: 'science'),
  ];
}
