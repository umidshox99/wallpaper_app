import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/presentation/blocs/search/search_bloc.dart';
import 'package:wallpaper_app/presentation/widgets/widgets.dart';

class Search extends StatefulWidget {
  String search;

  Search(
    this.search,
  );

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController controller = TextEditingController();
  int currentPage = 1;
  SearchBloc searchBloc;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Bottom poistion
      }
    });
    controller.text = widget.search;
    searchBloc = BlocProvider.of<SearchBloc>(context);
    print(widget.search);
    searchBloc.add(SearchEvent(widget.search, 1));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
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
                          if (controller.text.toString().isNotEmpty) {
                            setState(() {
                              currentPage = 0;
                            });
                            print(controller.text);
                            searchBloc.add(SearchEvent(controller.text, 1));
                          }
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
              BlocBuilder<SearchBloc, SearchState>(
                builder: (BuildContext context, state) {
                  if (state is LoadingSearchState)
                    return Container(child: CircularProgressIndicator());
                  else if (state is LoadedSearchState)
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
                                        searchBloc.add(SearchEvent(
                                            widget.search, currentPage));
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
                                  searchBloc.add(
                                      SearchEvent(widget.search, currentPage));
                                },
                                child: Icon(Icons.chevron_right),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        )
                      ],
                    );
                  else
                    return Container(
                      child: Text("Error"),
                    );
                },
                cubit: searchBloc,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
