import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/data/models/photos_data.dart';
import 'package:wallpaper_app/data/repositories/photos_repository_impl.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PhotosRepositoryImpl _repositoryImpl;

  SearchBloc(this._repositoryImpl) : super(null);

  @override
  SearchState get initialState => InitialSearchState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    List<Photos> list = [];
    if (event is SearchEvent) {
      yield LoadingSearchState();
      try {
        list = await _repositoryImpl.getSearched(event.query, event.page);
        yield LoadedSearchState(list);
      } catch (e) {
        yield ErrorSearchState();
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
