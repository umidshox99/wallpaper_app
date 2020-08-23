import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_app/data/models/photos_data.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class ImageView extends StatefulWidget {
  final url;
  final List<Photos> list;
  final int initial;

  ImageView(this.url, this.list, this.initial);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool downloading = false;
  var progressString = "";
  String name = "";

  @override
  void initState() {
    name = widget.url
        .toString()
        .split("/")[widget.url.toString().split("/").length - 1];
    print(name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
              tag: widget.url,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider.builder(
                  itemCount: widget.list.length,
                  itemBuilder: (BuildContext context, int itemIndex) =>
                      CachedNetworkImage(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    imageUrl: widget.list[itemIndex].src.portrait,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: widget.initial,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
//                    autoPlayCurve: Curves.fastOutSlowIn,
//                    enlargeCenterPage: true,
//                    onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              )),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _save();
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff1c1b1b).withOpacity(0.8),
                        ),
                        height: 50.0,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white54, width: 1),
                            gradient: LinearGradient(colors: <Color>[
                              Color(0x36FFFFFF),
                              Color(0x0FFFFFFF),
                            ])),
                        child: Column(
                          children: <Widget>[
                            Text("Set Wallpaper",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white70)),
                            Text(
                              "Image will be saved in galery",
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                )
              ],
            ),
          ),
          Align(
//            alignment: Alignment(0.0, 0.0),
              child: downloading
                  ? Container(
                      decoration: BoxDecoration(color: Colors.black45),
                      child: Center(
                          child: Container(
                        height: 120.0,
                        width: 200.0,
                        child: Card(
                          color: Colors.black87,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(),
                              SizedBox(height: 20.0),
                              Text(
                                "Downloading File $progressString",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      )),
                    )
                  : Text("")),
        ],
      ),
    );
  }

  Future _save() async {
    setState(() {
      downloading = true;
    });
    if (Platform.isAndroid) await _askPermission();
    var response = await Dio().get(widget.url,
        options: Options(
          responseType: ResponseType.bytes,
        ), onReceiveProgress: (rec, total) {
      setState(() {
        downloading = true;
        progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        print(progressString);
      });
    });
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
    );
    setState(() {
      downloading = false;
      if (progressString == "100%") {
        _setWallpaer(result);
      }
    });

    print(result + "UMID");
    Navigator.pop(context);
  }

  Future<Null> _setWallpaer(String name) async {
    int location = WallpaperManager
        .HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
    await WallpaperManager.setWallpaperFromFile(name, location);
  }

  _askPermission() async {
    if (await Permission.storage.request().isGranted) {
      print("object");
    }
  }
}
