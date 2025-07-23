import 'package:flutter/material.dart';

import 'package:news/sources/data/data_sources/sources_data_source.dart';
import 'package:news/sources/data/model/source.dart';
import 'package:news/sources/data/model/source_response.dart';

class SourcesViewModel with ChangeNotifier {
  SourcesDataSource dataSource = SourcesDataSource();
  List<Source> source = [];

  bool isLoading = false;
  String? errorMessage;

  Future getSources(String category) async {
    isLoading = true;
    notifyListeners();
    try {
      SourceResponse response = await dataSource.getSources(category);
      source = response.sources ?? [];
      if (response.status == 'ok' || response.sources != null) {
        source = response.sources!;
      } else {
        errorMessage = 'data feteching failed';
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
