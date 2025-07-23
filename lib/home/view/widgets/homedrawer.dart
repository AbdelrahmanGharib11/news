import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news/shared/theme/apptheme.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key, required this.returnToHome});
  VoidCallback returnToHome;
  @override
  Widget build(BuildContext context) {
    var screendim = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: screendim.width * 0.7,
      height: screendim.height,
      child: Column(
        children: [
          Container(
            color: AppTheme.secondary,
            alignment: Alignment.center,
            height: screendim.height * 0.22,
            width: double.infinity,
            child: Text('News App', style: textTheme.titleMedium),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              color: AppTheme.primary,
              width: double.infinity,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      returnToHome();
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/Home 1.svg',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Go To Home',
                          style: textTheme.headlineLarge?.copyWith(
                            color: AppTheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Divider(height: 1, color: AppTheme.secondary),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
