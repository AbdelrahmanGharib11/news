import 'package:flutter/material.dart';
import 'package:news/category/view/widgets/categoryitem.dart';
import 'package:news/category/data/models/category_model.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key, required this.selectedCategoryModel});
  void Function(CategoryModel) selectedCategoryModel;
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
                  (_, index) => InkWell(
                    onTap: () {
                      selectedCategoryModel(CategoryModel.categories[index]);
                    },
                    child: CategoryItem(
                      category: CategoryModel.categories[index],
                    ),
                  ),
              separatorBuilder: (_, _) => SizedBox(height: 15),
              itemCount: CategoryModel.categories.length,
            ),
          ],
        ),
      ),
    );
  }
}
