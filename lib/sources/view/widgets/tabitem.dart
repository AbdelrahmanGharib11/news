import 'package:flutter/material.dart';

import 'package:news/sources/data/model/source.dart';
import 'package:news/shared/theme/apptheme.dart';

class TabItem extends StatelessWidget {
  TabItem({super.key, required this.isSelected, required this.source});
  Source source;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(
      source.name!,
      style:
          isSelected
              ? textTheme.bodyLarge?.copyWith(color: AppTheme.secondary)
              : textTheme.titleSmall?.copyWith(color: AppTheme.secondary),
    );
  }
}
