import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/news/data/models/article.dart';
import 'package:news/news/data/repository/news.repo.dart';
import 'package:news/news/view_model/news_states.dart';
import 'package:news/shared/service/service_locator.dart';

class NewsViewModel extends Cubit<NewsStates> {
  late NewsRepo dataSource;
  NewsViewModel() : super(NewsInitialState()) {
    dataSource = NewsRepo(dataSource: ServiceLocator.newsDataSource);
  }

  Future getNews(String sourceId) async {
    emit(NewsLoadingState());
    try {
      final news = await dataSource.getNewsFromSources(sourceId);
      emit(NewsSuccessState(news));
    } catch (e) {
      emit(NewsErrorState(e.toString()));
    }
  }
}
