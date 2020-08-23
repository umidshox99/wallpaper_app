import 'dart:convert';

import 'package:http/http.dart';
import 'package:wallpaper_app/data/datasource/data.dart';
import 'package:wallpaper_app/data/models/photos_data.dart';

class APIProvider {
  Future<List<Photos>> getTrendsPhotos(int page) async {
    PhotosData _data = PhotosData();
    var response = await get(
        "https://api.pexels.com/v1/curated?per_page=80&page=$page",
        headers: header);
    if (response.statusCode == 200) {
      _data = PhotosData.fromJson(jsonDecode(response.body));
      print(_data.photos.length);
    } else {
      print("Error");
    }
    return _data.photos;
  }

  Future<List<Photos>> getSearched(String query, int page) async {
    PhotosData _data = PhotosData();
    var response = await get(
        "https://api.pexels.com/v1/search?query=$query&per_page=80&page=$page",
        headers: header);
    if (response.statusCode == 200) {
      _data = PhotosData.fromJson(jsonDecode(response.body));
      print(_data.photos.length);
    } else {
      print("Error");
    }
    return _data.photos;
  }
}
