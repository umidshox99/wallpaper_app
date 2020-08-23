import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/data/datasource/app_themes.dart';
import 'package:wallpaper_app/data/datasource/data.dart';
import 'package:wallpaper_app/data/models/categories_model.dart';
import 'package:wallpaper_app/data/models/photos_data.dart';
import 'package:wallpaper_app/presentation/blocs/fetch_trends/fetch_trends_bloc.dart';
import 'package:wallpaper_app/presentation/blocs/search/search_bloc.dart';
import 'package:wallpaper_app/presentation/blocs/theme_change/theme_bloc.dart';
import 'package:wallpaper_app/presentation/blocs/theme_change/theme_event.dart';
import 'package:wallpaper_app/presentation/screens/search.dart';
import 'package:wallpaper_app/presentation/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = new List();
  PhotosData data = PhotosData();
  TextEditingController controller = TextEditingController();
  FetchTrendsBloc bloc;
  SearchBloc searchBloc;
  ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  bool b = false;

  List<Photos> list = List();
  List<Photos> photos = List();

  @override
  void initState() {
    bloc = BlocProvider.of<FetchTrendsBloc>(context);
    searchBloc = BlocProvider.of<SearchBloc>(context);
    bloc.add(FetchTrendsEvent(currentPage));
    categories = getCategoriesModel();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("Hello whats up");
      }
    });
    super.initState();
  }

  @override
  void deactivate() {
    bloc.close();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).primaryColor ==
        appThemeData[AppTheme.Light].primaryColor;
//    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: brandName(),
        elevation: 0.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<ThemeBloc>(context)
                    .add(ThemeChanged(theme: AppTheme.values[isLight ? 1 : 0]));
              },
              child: isLight
                  ? Icon(Icons.brightness_high)
                  : Icon(Icons.brightness_low),
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.symmetric(horizontal: 24.0),
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: "Search wallpaper",
//                          hintStyle: TextStyle(color: Colors.grey[800]),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          if (controller.text.toString().isNotEmpty)
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => Search(
                                          controller.text.toString(),
                                        )));
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.black45,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 26.0,
              ),
              Container(
                height: 150,
                child: CarouselSlider.builder(
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int itemIndex) =>
                      CatecoryWidget(
                    categories[itemIndex].imgUrl,
                    categories[itemIndex].categorieName,
                  ),
                  options: CarouselOptions(
                    height: 150,
                    aspectRatio: 3 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
//                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
//                    enlargeCenterPage: true,
//                    onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              SizedBox(
                height: 26.0,
              ),
              BlocBuilder<FetchTrendsBloc, FetchTrendsState>(
                builder: (BuildContext context, state) {
                  if (state is LoadingFetchTrendsState) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (state is LoadedFetchTrendsState) {
//                    photos.addAll(state.list);
//                    if (photos.length > 20)
//                      for (int i = 0; i < 20; i++) {
//                        list.add(photos[i]);
//                      }
                    return Column(
                      children: <Widget>[
                        getCard(state.list ?? [], context, _scrollController),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            children: <Widget>[
                              currentPage > 1
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          currentPage--;
                                        });
                                        print("current   = " +
                                            currentPage.toString());
                                        bloc.add(FetchTrendsEvent(currentPage));
//                                        initialPage--;
                                      },
                                      child: Icon(Icons.keyboard_arrow_left),
                                    )
                                  : Text(""),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentPage++;
                                  });
                                  print(
                                      "current   = " + currentPage.toString());
                                  bloc.add(FetchTrendsEvent(currentPage));
//                                  currentPage = initialPage;
                                },
                                child: Icon(Icons.chevron_right),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        )
                      ],
                    );
                  } else
                    return Center(
                      child: Text("Error"),
                    );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
