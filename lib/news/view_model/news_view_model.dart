import 'package:flutter/widgets.dart';
import 'package:news/news/data/data_source/news_data_source.dart';
import 'package:news/news/data/models/article.dart';
import 'package:news/news/data/models/news_response.dart';

class NewsViewModel with ChangeNotifier {
  NewsDataSource dataSource = NewsDataSource();
  List<News_Model> news = [];
  bool isLoading = false;
  String? errorMessage;

  Future getNews(String sourceId) async {
    isLoading = true;
    notifyListeners();
    try {
      NewsResponse response = await dataSource.getNewsFromSources(sourceId);
      news = response.articles ?? [];
      if (response.status == 'ok' || response.articles != null) {
        news = response.articles!;
      } else {
        errorMessage = 'data feteching failed';
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
