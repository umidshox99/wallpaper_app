import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/models/photos_data.dart';
import 'package:wallpaper_app/presentation/screens/category.dart';
import 'package:wallpaper_app/presentation/screens/image_view.dart';

Widget brandName() {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
            text: 'Pexels',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Colors.red)),
        TextSpan(
            text: 'Wallpaper',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Colors.blue)),
      ],
    ),
  );
}

Widget getCard(List<Photos> list, context, controller) {
  return GridView.count(
      controller: controller,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: list.map((e) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ImageView(e.src.original, list, list.indexOf(e))));
            },
            child: Hero(
              tag: e.src.original,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                    imageUrl: e.src.medium,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList());
}

class CatecoryWidget extends StatelessWidget {
  final imageURL;
  final title;

  CatecoryWidget(this.imageURL, this.title);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Categories(title)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width,
                height: 150,
                fit: BoxFit.cover,
                imageUrl: imageURL,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                color: Colors.black26,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 28),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
