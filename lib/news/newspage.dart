import 'package:flutter/material.dart';
import 'package:news/news/newsitem.dart';
import 'package:news/model/source_model.dart';
import 'package:news/news/tabitem.dart';
import 'package:news/theme/apptheme.dart';

class NewsPage extends StatefulWidget {
  NewsPage({super.key, required this.categoryId});

  String categoryId;
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int currentIndex = 0;

  List<SourceModel> sources = List.generate(
    10,
    (index) => SourceModel(id: '$index', sourceName: 'source ${index + 1}'),
  );

  @override
  Widget build(BuildContext context) {
    var screendim = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: sources.length,
      child: Column(
        children: [
          TabBar(
            onTap: (index) {
              currentIndex = index;

              setState(() {});
            },
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: AppTheme.secondary,
            dividerColor: Colors.transparent,
            labelPadding: EdgeInsets.only(right: 16),
            padding: EdgeInsets.only(left: 16, top: 19.5, bottom: 19.5),
            tabs:
                sources
                    .map(
                      (source) => TabItem(
                        isSelected: currentIndex == sources.indexOf(source),
                        source: source,
                      ),
                    )
                    .toList(),
          ),
          SizedBox(height: 16),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.separated(
                itemBuilder:
                    (_, index) => InkWell(
                      onTap: () {
                        showNewsDatails(screendim.height);
                      },
                      child: NewsItem(
                        newsAuthor: 'Daniel Power',
                        newsDate: '18 minuts ago',
                        newsImage: 'assets/image/business.png',
                        newsText:
                            '40-year-old man falls 200 feet to his death while canyoneering at national park',
                      ),
                    ),
                separatorBuilder: (_, _) => SizedBox(height: 16),
                itemCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showNewsDatails(double height) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      builder:
          (context) => Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppTheme.secondary,
              ),
              height: height * 0.5,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      'assets/image/business.png',
                      width: double.infinity,
                      height: height * 0.25,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '40-year-old man falls 200 feet to his death while canyoneering at national park 40-year-old man falls 200 feet to his death while canyoneering at national park',
                    softWrap: true,
                    maxLines: 5,
                    overflow: TextOverflow.fade,
                    style: TextTheme.of(context).bodyLarge,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: AppTheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fixedSize: Size(double.infinity, height * 0.07),
                    ),
                    child: Center(
                      child: Text(
                        'View Full Artical',
                        style: TextTheme.of(
                          context,
                        ).bodyLarge?.copyWith(color: AppTheme.secondary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
