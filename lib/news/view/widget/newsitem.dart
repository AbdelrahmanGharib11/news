import 'package:flutter/material.dart';
import 'package:news/shared/theme/apptheme.dart';

class NewsItem extends StatelessWidget {
  NewsItem({
    super.key,
    required this.newsAuthor,
    required this.newsDate,
    required this.newsImage,
    required this.newsText,
  });

  String newsImage;
  String newsText;
  String newsDate;
  String newsAuthor;
  @override
  Widget build(BuildContext context) {
    var screendim = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.secondary, width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      height: screendim.height * 0.41,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              newsImage,
              height: screendim.height * 0.272,
              width: double.infinity,
              fit: BoxFit.fill,
              errorBuilder:
                  (context, error, stackTrace) => Image.asset(
                    'assets/image/emptyphoto.png',
                    height: screendim.height * 0.272,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            newsText,
            style: textTheme.bodyLarge?.copyWith(color: AppTheme.secondary),
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'By: $newsAuthor',
                  style: textTheme.labelLarge?.copyWith(color: AppTheme.gray),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Spacer(),
              Text(
                newsDate,
                style: textTheme.labelLarge?.copyWith(color: AppTheme.gray),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
