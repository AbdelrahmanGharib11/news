import 'package:news/news/data/data_source/news_data_source.dart';
import 'package:news/news/data/models/article.dart';

class NewsRepo {
  NewsRepo({required this.dataSource});
  NewsDataSource dataSource;
  Future<List<News_Model>> getNewsFromSources(String sourceId) async {
    return dataSource.getNewsFromSources(sourceId);
  }
}
