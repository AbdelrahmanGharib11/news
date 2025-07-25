import 'package:news/sources/data/data_sources/source_data_source.dart';
import 'package:news/sources/data/data_sources/sources_api_data_source.dart';
import 'package:news/sources/data/model/source.dart';

class SourcesRepo {
  SourcesRepo({required this.dataSource});
  SourcesDataSource dataSource;
  Future<List<Source>> getSources(String categoryId) async {
    return dataSource.getSources(categoryId);
  }
}
