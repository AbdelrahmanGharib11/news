import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/category/categorypage.dart';
import 'package:news/theme/apptheme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: Text(
          'Home',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppTheme.secondary),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu_rounded, size: 26, color: AppTheme.secondary),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.search,
              size: 26,
              color: AppTheme.secondary,
            ),
          ),
        ],
      ),
      body: CategoryPage(),
    );
  }
}
