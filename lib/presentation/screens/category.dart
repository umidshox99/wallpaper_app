import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/data/models/photos_data.dart';
import 'package:wallpaper_app/presentation/blocs/search/search_bloc.dart';
import 'package:wallpaper_app/presentation/widgets/widgets.dart';

class Categories extends StatefulWidget {
  final String name;

  Categories(this.name);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  PhotosData data = PhotosData();
  int currentPage = 1;
  SearchBloc bloc;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Bottom poistion
      }
    });
    print(widget.name);
    bloc = BlocProvider.of<SearchBloc>(context);
    bloc.add(SearchEvent(widget.name, 1));
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: brandName(),
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: BlocBuilder<SearchBloc, SearchState>(
            cubit: bloc,
            builder: (BuildContext context, state) {
              if (state is LoadedSearchState)
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
                                    bloc.add(
                                        SearchEvent(widget.name, currentPage));
                                  },
                                  child: Icon(Icons.keyboard_arrow_left),
                                )
                              : Text(""),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentPage++;
                              });
                              print("current   = " + currentPage.toString());
                              bloc.add(SearchEvent(widget.name, currentPage));
                            },
                            child: Icon(Icons.chevron_right),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    )
                  ],
                );
              else if (state is ErrorSearchState)
                return Center(
                  child: Text("error"),
                );
              else
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                );
            },
          ),
        ),
      ),
    );
  }
}
