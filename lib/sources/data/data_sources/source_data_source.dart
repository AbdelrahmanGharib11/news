import 'package:news/sources/data/model/source.dart';

abstract class SourcesDataSource {
  Future<List<Source>> getSources(String categoryId);
}
