part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class InitialSearchState extends SearchState {}

class LoadingSearchState extends SearchState {}

class LoadedSearchState extends SearchState {
  final List<Photos> list;

  LoadedSearchState(this.list);
}

class ErrorSearchState extends SearchState {}
