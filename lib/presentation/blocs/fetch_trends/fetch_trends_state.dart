part of 'fetch_trends_bloc.dart';

@immutable
abstract class FetchTrendsState {}

class InitialFetchTrendsState extends FetchTrendsState {}

class LoadingFetchTrendsState extends FetchTrendsState {}

class LoadedFetchTrendsState extends FetchTrendsState {
  final List<Photos> list;
  final bool hasReachedMax;

  LoadedFetchTrendsState(this.list, this.hasReachedMax);

  LoadedFetchTrendsState copyWith({
    List<Photos> list,
    bool hasReachedMax,
  }) {
    return LoadedFetchTrendsState(
      list ?? this.list,
      hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [list, hasReachedMax];

  @override
  String toString() =>
      'LoadedFetchTrendsState { posts: ${list.length}, hasReachedMax: $hasReachedMax }';
}

class ErrorFetchTrendsState extends FetchTrendsState {}
