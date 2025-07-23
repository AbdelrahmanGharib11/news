import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/shared/constants/constants.dart';
import 'package:news/news/data/models/news_response.dart';

class SearchDataSource {
  String bseUrl = ApiConstant.baseUrl;
  String sourceEndpoint = ApiConstant.sourceEndpoint;

  Future<NewsResponse> searchForNews(String query) async {
    if (query.isEmpty) {
      return NewsResponse(status: 'ok', articles: []);
    }

    Uri uri = Uri.http(ApiConstant.baseUrl, ApiConstant.newsEndpoint, {
      'apiKey': '910e03f33be748d0a58c2d9039391490',
      'q': query,
    });

    http.Response response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load news: ${response.statusCode}');
    }

    Map<String, dynamic> json = jsonDecode(response.body);

    if (json['status'] == 'error') {
      throw Exception(json['message'] ?? 'Unknown error occurred');
    }

    return NewsResponse.fromJson(json);
  }
}
