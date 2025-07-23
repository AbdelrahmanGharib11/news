import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/shared/constants/constants.dart';
import 'package:news/news/data/models/news_response.dart';

class NewsDataSource {
  Future<NewsResponse> getNewsFromSources(String sourceId) async {
    Uri uri = Uri.http(ApiConstant.baseUrl, ApiConstant.newsEndpoint, {
      'apiKey': '910e03f33be748d0a58c2d9039391490',
      'sources': sourceId,
    });

    http.Response response = await http.get(uri);

    Map<String, dynamic> json = jsonDecode(response.body);

    return NewsResponse.fromJson(json);
  }
}
