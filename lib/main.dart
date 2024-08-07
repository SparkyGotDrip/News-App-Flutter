import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff000000),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: const Color(0xff000000),
      ),
      themeMode: ThemeMode.dark,
      home: NewsApp(),
    );
  }
}

class NewsApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewsAppState();
  }
}

class NewsAppState extends State<NewsApp> {
  String data = "";
  var newsdata;

  @override
  void initState() {
    super.initState();
    getData("all");
  }

  Future<void> getData(String category) async {
    http.Response response = await http.get(
        Uri.parse("https://inshortsapi.vercel.app/news?category=$category"));
    setState(() {
      data = response.body;
      newsdata = jsonDecode(data)["data"];
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 12,
        child: Scaffold(
          appBar: AppBar(
            title: Text("FLUTTER NEWS"),
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  text: "Top News",
                ),
                Tab(
                  text: "National",
                ),
                Tab(
                  text: "Business",
                ),
                Tab(
                  text: "Sports",
                ),
                Tab(
                  text: "World",
                ),
                Tab(
                  text: "Politics",
                ),
                Tab(
                  text: "Technology",
                ),
                Tab(
                  text: "Startup",
                ),
                Tab(
                  text: "Entertainment",
                ),
                Tab(
                  text: "Miscellaneuous",
                ),
                Tab(
                  text: "Hatke",
                ),
                Tab(
                  text: "Science",
                ),
              ],
              onTap: (index) {
                String category = '';
                if (index >= 13) {
                  category = 'Invalid category';
                } else {
                  category = [
                    'all',
                    'national',
                    'business',
                    'sports',
                    'world',
                    'politics',
                    'technology',
                    'startup',
                    'entertainment',
                    'miscellaneous',
                    'hatke',
                    'science',
                    'Automobile'
                  ][index];
                }
                getData(category);
              },
            ),
          ),
          body: ListView.builder(
              itemCount: newsdata.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin:
                      EdgeInsets.only(top: 12.0, left: 5, right: 5, bottom: 6),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 0, left: 0, bottom: 12.0, right: 0),
                    child: Column(children: [
                      Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                            child: Image.network(
                              newsdata[index]["imageUrl"],
                              fit: BoxFit.fill,
                              height: 175,
                              width: double.infinity,
                            ),
                          ),
                          Positioned(
                              bottom: 12.0,
                              left: 20.0,
                              child: Text(
                                newsdata[index]["author"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 0.0,
                                top: 0,
                                right: 8.0,
                                bottom: 8.0,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8, top: 3.5, bottom: 3.5),
                                  child: Text(
                                    newsdata[index]["date"],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        title: Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Text(
                            newsdata[index]["title"],
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10.0, top: 0, right: 8.0),
                        child: Text(
                          newsdata[index]["content"],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 10.0, top: 10, right: 0),
                          child: Text(
                            newsdata[index]["time"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ]),
                  ),
                );
              }),
        ));
  }
}
