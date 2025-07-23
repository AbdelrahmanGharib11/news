import 'article.dart';

class NewsResponse {
  String? status;
  int? totalResults;
  List<News_Model>? articles;

  NewsResponse({this.status, this.totalResults, this.articles});

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
    status: json['status'] as String?,
    totalResults: json['totalResults'] as int?,
    articles:
        (json['articles'] as List<dynamic>?)
            ?.map((e) => News_Model.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  // Map<String, dynamic> toJson() => {
  //   'status': status,
  //   'totalResults': totalResults,
  //   'articles': articles?.map((e) => e.toJson()).toList(),
  // };
}
