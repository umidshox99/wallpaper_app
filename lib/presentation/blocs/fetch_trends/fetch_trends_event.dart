part of 'fetch_trends_bloc.dart';

@immutable
class FetchTrendsEvent {
  final int page;

  FetchTrendsEvent(this.page);
}
