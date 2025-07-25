import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/service/service_locator.dart';
import 'package:news/sources/data/repositories/sources_repo.dart';
import 'package:news/sources/viewmodel/sources_states.dart';

class SourcesViewModel extends Cubit<SourcesStates> {
  late SourcesRepo dataSource;

  SourcesViewModel() : super(SourcesInitialState()) {
    dataSource = SourcesRepo(dataSource: ServiceLocator.sourcesDataSource);
  }

  Future getSources(String category) async {
    emit(SourcesLoadingState());
    try {
      final source = await dataSource.getSources(category);
      emit(SourcesSuccessState(source));
    } catch (e) {
      emit(SourcesErrorState(e.toString()));
    }
  }
}
