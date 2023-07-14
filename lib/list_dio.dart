import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/description_page.dart';
import 'package:news_app/progress_indicator.dart';
import 'package:news_app/search_field_page.dart';

import 'bookmark.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  dynamic jsonList = [];

  void getData() async {
    try {
      var response = await Dio().get('https://inshorts.deta.dev/news?category');
      if (response.statusCode == 200) {
        setState(() {
          jsonList = response.data['data'] as List;
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return jsonList.isEmpty
        ? const ProgressIndicatorExample()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.indigo.shade900,
              title: const Text(
                'List',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MySearchField()));
                  },
                  icon: const Icon(
                    Icons.search_sharp,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Bookmark(),
                        ));
                  },
                  icon: const Icon(
                    Icons.bookmark,
                  ),
                )
              ],
            ),
            body: ListView.builder(
              itemCount: jsonList.length,
              itemBuilder: (context, index) {
                final item = jsonList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Description(
                              id: item,
                            ),
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.indigo.shade900, width: 3),
                          color: Colors.indigo.shade600,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        topLeft: Radius.circular(40))),
                                padding: const EdgeInsets.all(18),
                                height: 350,
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  jsonList[index]['imageUrl'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        jsonList[index]['title'],
                                        style: GoogleFonts.akshar(fontSize: 21),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(jsonList[index]['date']),
                                          Text(jsonList[index]['author']),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
