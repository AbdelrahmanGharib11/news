import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/shared/constants/constants.dart';
import 'package:news/sources/data/model/source_response.dart';

class SourcesDataSource {
  Future<SourceResponse> getSources(String categoryId) async {
    Uri uri = Uri.http(ApiConstant.baseUrl, ApiConstant.sourceEndpoint, {
      'apiKey': '910e03f33be748d0a58c2d9039391490',
      'category': categoryId,
    });

    http.Response response = await http.get(uri);

    Map<String, dynamic> json = jsonDecode(response.body);

    return SourceResponse.fromJson(json);
  }
}
