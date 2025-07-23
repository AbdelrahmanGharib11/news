import 'source.dart';

class SourceResponse {
  String? status;
  List<Source>? sources;

  SourceResponse({this.status, this.sources});

  factory SourceResponse.fromJson(Map<String, dynamic> json) {
    return SourceResponse(
      status: json['status'] as String?,
      sources:
          (json['sources'] as List<dynamic>?)
              ?.map((e) => Source.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}
