import 'package:wallpaper_app/data/models/photos_data.dart';
import 'package:wallpaper_app/domain/repositories/photos_repository.dart';
import 'package:wallpaper_app/domain/usecases/api_provider.dart';

class PhotosRepositoryImpl implements PhotosRepository {
  final APIProvider apiProvider;

  PhotosRepositoryImpl(this.apiProvider);

  @override
  Future<List<Photos>> getCurated(int page) =>
      apiProvider.getTrendsPhotos(page);

  @override
  Future<List<Photos>> getSearched(String query, int page) =>
      apiProvider.getSearched(query, page);

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}
