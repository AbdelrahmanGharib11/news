import 'package:flutter/material.dart';
import 'package:news/model/source_model.dart';
import 'package:news/theme/apptheme.dart';

class TabItem extends StatelessWidget {
  TabItem({super.key, required this.isSelected, required this.source});
  SourceModel source;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      source.sourceName,
      style:
          isSelected
              ? textTheme.bodyLarge?.copyWith(color: AppTheme.secondary)
              : textTheme.titleSmall?.copyWith(color: AppTheme.secondary),
    );
  }
}
