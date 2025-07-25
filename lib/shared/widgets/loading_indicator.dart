import 'package:flutter/material.dart';
import 'package:news/shared/theme/apptheme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: AppTheme.secondary, strokeWidth: 4);
  }
}
