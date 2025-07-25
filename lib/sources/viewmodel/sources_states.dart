import 'package:news/sources/data/model/source.dart';

abstract class SourcesStates {}

class SourcesInitialState extends SourcesStates {}

class SourcesLoadingState extends SourcesStates {}

class SourcesSuccessState extends SourcesStates {
  final List<Source> sources;

  SourcesSuccessState(this.sources);
}

class SourcesErrorState extends SourcesStates {
  final String error;

  SourcesErrorState(this.error);
}
