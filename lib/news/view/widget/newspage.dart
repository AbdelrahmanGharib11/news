import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/news/data/models/article.dart';
import 'package:news/news/view_model/news_states.dart';
import 'package:news/news/view_model/news_view_model.dart';
import 'package:news/sources/data/model/source.dart';
import 'package:news/news/view/widget/newsitem.dart';
import 'package:news/sources/view/widgets/tabitem.dart';
import 'package:news/sources/viewmodel/sources_states.dart';
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

    return BlocProvider<SourcesViewModel>(
      create: (_) => viewModel,

      child: BlocBuilder<SourcesViewModel, SourcesStates>(
        builder: (context, state) {
          if (state is SourcesLoadingState) {
            return Align(
              alignment: Alignment.center,
              child: LoadingIndicator(),
            );
          } else if (state is SourcesErrorState) {
            return Align(
              alignment: Alignment.center,
              child: ErrorIndicator(message: state.error),
            );
          } else if (state is SourcesSuccessState) {
            final sources = state.sources;
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
                  child: BlocProvider(
                    create: (_) => newsViewModel,

                    child: BlocBuilder<NewsViewModel, NewsStates>(
                      builder: (context, state) {
                        if (state is NewsLoadingState) {
                          return Align(
                            alignment: Alignment.center,
                            child: LoadingIndicator(),
                          );
                        } else if (state is NewsErrorState) {
                          return Align(
                            alignment: Alignment.center,
                            child: ErrorIndicator(message: state.error),
                          );
                        } else if (state is NewsSuccessState) {
                          final news = state.news;
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
                        } else {
                          return Align(
                            alignment: Alignment.center,
                            child: Text('No News Found'),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Align(
              alignment: Alignment.center,
              child: Text('No Sources Found'),
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
                  news.content ?? news.title!,
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
