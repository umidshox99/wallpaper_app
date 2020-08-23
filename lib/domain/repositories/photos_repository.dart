import 'package:equatable/equatable.dart';
import 'package:wallpaper_app/data/models/photos_data.dart';

abstract class PhotosRepository extends Equatable {
  Future<List<Photos>> getCurated(int page);
  Future<List<Photos>> getSearched(String text, int page);
}
