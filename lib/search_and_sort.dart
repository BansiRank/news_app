import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bookmark.dart';
import 'description_page.dart';

class SearchSort extends StatefulWidget {
  const SearchSort({Key? key}) : super(key: key);

  @override
  State<SearchSort> createState() => _SearchSortState();
}

class _SearchSortState extends State<SearchSort> {
  bool searchMode = false;
  dynamic jsonList = [];
  bool isTextFieldEnable = true;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

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

  void filterData(String input) {
    setState(() {
      jsonList = jsonList.where((item) {
        final title = item['title'].toString().toLowerCase();
        final author = item['author'].toString().toLowerCase();
        return title.contains(input.toLowerCase()) ||
            author.contains(input.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.indigo.shade900,
          title: searchMode
              ? TextField(
                  style: const TextStyle(color: Colors.white),
                  focusNode: _focusNode,
                  readOnly: isTextFieldEnable,
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Search news...',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  onChanged: filterData,
                )
              : const Text(
                  'News',
                  style: TextStyle(color: Colors.white),
                ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  searchMode = !searchMode;
                  if (searchMode) {
                    FocusScope.of(context).requestFocus(_focusNode);
                    isTextFieldEnable = false;
                  } else {
                    getData();
                  }
                });
              },
              icon: searchMode
                  ? const Icon(Icons.close)
                  : const Icon(Icons.search_sharp),
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
      ),
      body: jsonList.isEmpty
          ? Center(
              child: Text(
          'No Data Found',
          style: GoogleFonts.aboreto(
              fontSize: 40, fontWeight: FontWeight.bold),
            ))
          : ListView.builder(
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
