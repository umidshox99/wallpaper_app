import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/data/models/photos_data.dart';
import 'package:wallpaper_app/data/repositories/photos_repository_impl.dart';

part 'fetch_trends_event.dart';
part 'fetch_trends_state.dart';

class FetchTrendsBloc extends Bloc<FetchTrendsEvent, FetchTrendsState> {
  final PhotosRepositoryImpl _repositoryImpl;

  FetchTrendsBloc(this._repositoryImpl) : super(null);

  @override
  FetchTrendsState get initialState => InitialFetchTrendsState();

  @override
  Stream<FetchTrendsState> mapEventToState(FetchTrendsEvent event) async* {
    List<Photos> list = [];
    if (event is FetchTrendsEvent) {
      yield LoadingFetchTrendsState();
      try {
        list = await _repositoryImpl.getCurated(event.page);
        yield LoadedFetchTrendsState(list, false);
      } catch (e) {
        yield ErrorFetchTrendsState();
      }
    }
  }
}
