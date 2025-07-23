import 'package:flutter/material.dart';
import 'package:news/category/data/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({super.key, required this.category});
  CategoryModel category;
  @override
  Widget build(BuildContext context) {
    var screendim = MediaQuery.sizeOf(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        'assets/image/${category.imageName}.png',
        height: screendim.height * 0.25,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
