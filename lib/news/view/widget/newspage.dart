import 'package:flutter/material.dart';
import 'package:news/news/data/models/article.dart';
import 'package:news/news/view_model/news_view_model.dart';
import 'package:news/sources/data/model/source.dart';
import 'package:news/news/view/widget/newsitem.dart';
import 'package:news/sources/view/widgets/tabitem.dart';
import 'package:news/sources/viewmodel/sources_view_model.dart';
import 'package:news/shared/theme/apptheme.dart';
import 'package:news/shared/widgets/error_indicator.dart';
import 'package:news/shared/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  NewsPage({super.key, required this.categoryId});

  String categoryId;
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int currentIndex = 0;
  SourcesViewModel viewModel = SourcesViewModel();
  NewsViewModel newsViewModel = NewsViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getSources(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    var screendim = MediaQuery.sizeOf(context);

    return ChangeNotifierProvider(
      create: (context) => viewModel,

      child: Consumer<SourcesViewModel>(
        builder: (context, viewModel, __) {
          if (viewModel.isLoading) {
            return Align(
              alignment: Alignment.center,
              child: LoadingIndicator(),
            );
          } else if (viewModel.errorMessage != null) {
            return Align(
              alignment: Alignment.center,
              child: ErrorIndicator(message: viewModel.errorMessage!),
            );
          } else {
            List<Source> sources = viewModel.source;
            newsViewModel.getNews(sources[currentIndex].id!);
            return Column(
              children: [
                DefaultTabController(
                  length: sources.length,
                  child: TabBar(
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
                                isSelected:
                                    currentIndex == sources.indexOf(source),
                                source: source,
                              ),
                            )
                            .toList(),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ChangeNotifierProvider(
                    create: (context) => newsViewModel,

                    child: Consumer<NewsViewModel>(
                      builder: (context, newsViewModel, __) {
                        if (newsViewModel.isLoading) {
                          return Align(
                            alignment: Alignment.center,
                            child: LoadingIndicator(),
                          );
                        } else if (newsViewModel.errorMessage != null) {
                          return Align(
                            alignment: Alignment.center,
                            child: ErrorIndicator(
                              message: newsViewModel.errorMessage!,
                            ),
                          );
                        } else {
                          List<News_Model> news = newsViewModel.news;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: ListView.separated(
                              itemBuilder: (_, index) {
                                String publishedAt =
                                    news[index].publishedAt!.toString();
                                DateTime publishedDate = DateTime.parse(
                                  publishedAt,
                                );
                                DateTime now = DateTime.now().toUtc();

                                String timeAgoText = timeago.format(
                                  publishedDate,
                                  locale: 'en',
                                );
                                return InkWell(
                                  onTap: () {
                                    showNewsDatails(
                                      screendim.height,
                                      news[index],
                                      context,
                                    );
                                  },
                                  child: NewsItem(
                                    newsAuthor: news[index].author ?? 'Unknown',
                                    newsDate: timeAgoText,
                                    newsImage:
                                        news[index].urlToImage ??
                                        'assets/image/emptyphoto.png',
                                    newsText: news[index].title!,
                                  ),
                                );
                              },
                              separatorBuilder: (_, _) => SizedBox(height: 16),
                              itemCount: news.length,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

void showNewsDatails(double height, News_Model news, BuildContext context) {
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
                  child: Image.network(
                    news.urlToImage ?? 'assets/image/emptyphoto.png',
                    width: double.infinity,
                    height: height * 0.25,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/image/emptyphoto.png',
                        width: double.infinity,
                        height: height * 0.25,
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  news.content!,
                  softWrap: true,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextTheme.of(context).bodyLarge,
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    openNewsWebsite(news.url!);
                  },
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

Future<bool> openNewsWebsite(String url) async {
  try {
    String processedUrl = url;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      processedUrl = 'https://$url';
    }

    final Uri uri = Uri.parse(processedUrl);

    try {
      if (await canLaunchUrl(uri)) {
        final success = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (success) return true;
      }
    } catch (e) {
      print('External app launch failed: $e');
    }

    try {
      final success = await launchUrl(uri, mode: LaunchMode.platformDefault);
      if (success) return true;
    } catch (e) {
      print('Platform default launch failed: $e');
    }

    try {
      final success = await launchUrl(
        uri,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      );
      if (success) return true;
    } catch (e) {
      print('In-app web view launch failed: $e');
    }

    return false;
  } catch (e) {
    print('Error in launchUrlRobust: $e');
    return false;
  }
}
