import 'package:flutter/widgets.dart';
import 'package:news/news/data/models/article.dart';
import 'package:news/news/data/models/news_response.dart';
import 'package:news/search/data/data_source/search_data_source.dart';

class SearchViewModel with ChangeNotifier {
  SearchDataSource dataSource = SearchDataSource();
  List<News_Model> news = [];
  bool isLoading = false;
  String? errorMessage;

  Future searchForNews(String query) async {
    isLoading = true;
    notifyListeners();
    try {
      NewsResponse response = await dataSource.searchForNews(query);
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
