import 'package:news/news/data/data_source/news_api_data_source.dart';
import 'package:news/news/data/data_source/news_data_source.dart';
import 'package:news/sources/data/data_sources/source_data_source.dart';
import 'package:news/sources/data/data_sources/sources_api_data_source.dart';

class ServiceLocator {
  static SourcesDataSource sourcesDataSource = SourcesApiDataSource();
  static NewsDataSource newsDataSource = NewsApiDataSource();
}
