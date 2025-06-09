import 'package:flutter/material.dart';
import 'package:news/category/categoryitem.dart';
import 'package:news/model/category_model.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning\nHere is Some News For You',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(height: 15),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder:
                  (_, index) =>
                      CategoryItem(category: CategoryModel.categories[index]),
              separatorBuilder: (_, _) => SizedBox(height: 15),
              itemCount: CategoryModel.categories.length,
            ),
          ],
        ),
      ),
    );
  }
}
