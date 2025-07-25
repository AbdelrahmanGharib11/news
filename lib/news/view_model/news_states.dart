import 'package:news/news/data/models/article.dart';

abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsLoadingState extends NewsStates {}

class NewsSuccessState extends NewsStates {
  final List<News_Model> news;

  NewsSuccessState(this.news);
}

class NewsErrorState extends NewsStates {
  final String error;

  NewsErrorState(this.error);
}
