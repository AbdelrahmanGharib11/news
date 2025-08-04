import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/category/categorypage.dart';
import 'package:news/drawers/homedrawer.dart';
import 'package:news/model/category_model.dart';
import 'package:news/news/newspage.dart';
import 'package:news/theme/apptheme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: Text(
          selectedCategory == null ? 'Home' : selectedCategory!.name,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppTheme.secondary),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('search');
            },
            icon: Icon(
              CupertinoIcons.search,
              size: 26,
              color: AppTheme.secondary,
            ),
          ),
        ],
      ),
      body:
          selectedCategory == null
              ? CategoryPage(selectedCategoryModel: selectedCategoryModel)
              : NewsPage(categoryId: selectedCategory!.id),
      drawer: HomeDrawer(returnToHome: returnToHome),
    );
  }

  void selectedCategoryModel(CategoryModel category) {
    selectedCategory = category;
    setState(() {});
    print(selectedCategory!.name);
  }

  void returnToHome() {
    selectedCategory = null;
    setState(() {});
  }
}
