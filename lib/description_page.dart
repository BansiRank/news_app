import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

List bookmark = [];

class Description extends StatefulWidget {
  const Description({super.key, this.id});

  final dynamic id;

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: const Text('News'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.indigo.shade900,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: DraggableScrollableSheet(
            minChildSize: 1,
            maxChildSize: 1,
            initialChildSize: 1,
            builder: (context, scrollController) => Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                                style: const ButtonStyle(
                                    iconSize: MaterialStatePropertyAll(90)),
                                onPressed: () {
                                  setState(() {
                                    isBookmarked = !isBookmarked;

                                    if (isBookmarked) {
                                      bookmark.add(widget.id);
                                      Fluttertoast.showToast(
                                        msg: 'Article saved',
                                        backgroundColor: Colors.grey,
                                      );
                                    } else {
                                      bookmark.remove(widget.id);
                                      Fluttertoast.showToast(
                                        msg: 'Article removed',
                                        backgroundColor: Colors.grey,
                                      );
                                    }
                                  });
                                },
                                icon: Icon(
                                  isBookmarked
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: Colors.indigo.shade900,
                                )),
                          ),
                          IconButton(
                              onPressed: () {

                                Share.share(widget.id['title'].toString());


                              },
                              icon: Icon(
                                Icons.share,
                                color: Colors.indigo.shade900,
                              ))
                        ],
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                topLeft: Radius.circular(40))),
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          widget.id['imageUrl'],
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.id['title'],
                          style: GoogleFonts.actor(fontSize: 30),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date: ${widget.id['date']}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          Text("Date: ${widget.id['author']}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.id['content'],
                          style: GoogleFonts.actor(fontSize: 15),
                        ),
                      ),
                    ]),
              ),
            )
          ),
        ),
      )),
    );
  }

}

