import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/news/data/data_source/news_data_source.dart';
import 'package:news/news/data/models/article.dart';
import 'package:news/shared/constants/constants.dart';
import 'package:news/news/data/models/news_response.dart';

class NewsApiDataSource extends NewsDataSource {
  @override
  Future<List<News_Model>> getNewsFromSources(String sourceId) async {
    Uri uri = Uri.http(ApiConstant.baseUrl, ApiConstant.newsEndpoint, {
      'apiKey': '910e03f33be748d0a58c2d9039391490',
      'sources': sourceId,
    });

    http.Response response = await http.get(uri);

    Map<String, dynamic> json = jsonDecode(response.body);

    NewsResponse newsResponse = NewsResponse.fromJson(json);

    if (newsResponse.status == 'ok' || newsResponse.articles != null) {
      return newsResponse.articles!;
    } else {
      throw Exception('Failed to load sources');
    }
  }
}
