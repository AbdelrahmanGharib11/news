import 'package:news/news/data/models/article.dart';

abstract class NewsDataSource {
  Future<List<News_Model>> getNewsFromSources(String sourceId);
}
