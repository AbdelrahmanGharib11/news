import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:news/news/data/models/article.dart';
import 'package:news/news/view/widget/newsitem.dart';
import 'package:news/search/view_model/search_view_model.dart';
import 'package:news/shared/theme/apptheme.dart';
import 'package:news/shared/widgets/error_indicator.dart';
import 'package:news/shared/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchEditingController = TextEditingController();
  SearchViewModel viewModel = SearchViewModel();
  bool ischanged = false;
  String? searched;
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    searchEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screendim = MediaQuery.sizeOf(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 21, right: 16, left: 16),
          child: Column(
            children: [
              SizedBox(
                height: screendim.height * 0.08,
                child: TextFormField(
                  style: textTheme.labelSmall,
                  cursorColor: AppTheme.secondary,
                  cursorErrorColor: AppTheme.red,
                  controller: searchEditingController,
                  onChanged: (query) {
                    searched = query;
                    _debounceTimer?.cancel();
                    _debounceTimer = Timer(Duration(milliseconds: 500), () {
                      if (query.isNotEmpty) {
                        viewModel.searchForNews(query);
                      }
                    });
                    setState(() {});
                  },
                  maxLines: 2,
                  onTapOutside:
                      (_) => FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: textTheme.labelSmall,
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppTheme.secondary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppTheme.secondary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppTheme.secondary,
                      ),
                    ),

                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: AppTheme.secondary,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => searchEditingController.clear(),
                      icon: Icon(
                        CupertinoIcons.multiply,
                        color: AppTheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ChangeNotifierProvider(
                create: (context) => viewModel,

                child: Consumer<SearchViewModel>(
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
                      List<News_Model> newsList = viewModel.news;
                      return searched != ''
                          ? newsList.isEmpty
                              ? Expanded(
                                child: Center(
                                  child: Text(
                                    'there are no news match your search',
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(color: AppTheme.secondary),
                                  ),
                                ),
                              )
                              : Expanded(
                                child: ListView.separated(
                                  itemBuilder: (_, index) {
                                    String publishedAt =
                                        newsList[index].publishedAt
                                            ?.toString() ??
                                        '';
                                    DateTime publishedDate =
                                        publishedAt.isNotEmpty
                                            ? DateTime.parse(publishedAt)
                                            : DateTime.now();

                                    String timeAgoText = timeago.format(
                                      publishedDate,
                                      locale: 'en',
                                    );
                                    return InkWell(
                                      onTap: () {
                                        showNewsDatails(
                                          screendim.height,
                                          newsList[index],
                                        );
                                      },
                                      child: NewsItem(
                                        newsAuthor:
                                            newsList[index].author ?? 'Unknown',
                                        newsDate: timeAgoText,
                                        newsImage:
                                            newsList[index].urlToImage ??
                                            'assets/image/emptyphoto.png',
                                        newsText:
                                            newsList[index].title ?? 'No Title',
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (_, _) => SizedBox(height: 16),
                                  itemCount: newsList.length,
                                ),
                              )
                          : Expanded(
                            child: SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'No Results..!',
                                  style: textTheme.displaySmall,
                                ),
                              ),
                            ),
                          );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showNewsDatails(double height, News_Model news) {
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
                    child:
                        news.urlToImage != null && news.urlToImage!.isNotEmpty
                            ? Image.network(
                              news.urlToImage!,
                              width: double.infinity,
                              height: height * 0.25,
                              fit: BoxFit.fill,
                              errorBuilder:
                                  (context, error, stackTrace) => Image.asset(
                                    'assets/image/emptyphoto.png',
                                    width: double.infinity,
                                    height: height * 0.25,
                                    fit: BoxFit.fill,
                                  ),
                            )
                            : Image.asset(
                              'assets/image/emptyphoto.png',
                              width: double.infinity,
                              height: height * 0.25,
                              fit: BoxFit.fill,
                            ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    news.content ?? 'No content available',
                    softWrap: true,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextTheme.of(context).bodyLarge,
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (news.url != null) {
                        openNewsWebsite(news.url!);
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Wrong Data!!',
                          fontSize: 16,
                          backgroundColor: AppTheme.secondary,
                          textColor: AppTheme.primary,
                          toastLength: Toast.LENGTH_SHORT,
                        );
                        Navigator.pop(context);
                      }
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
}
