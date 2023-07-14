import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'description_page.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo.shade900,
        appBar: AppBar(
          backgroundColor: Colors.indigo.shade900,
          title: const Text('Bookmarked Articles'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                alignment: Alignment.bottomCenter,
                child: ListView.builder(
                  itemCount: bookmark.length,
                  itemBuilder: (context, index) {
                    return bookmark.isEmpty
                        ? const Text('No Articles Bookmarked')
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Description(
                                              id: bookmark[index],
                                            )));
                              },
                              tileColor: Colors.grey,
                              title: Text(
                                bookmark[index]['title'],
                                style: GoogleFonts.actor(fontSize: 15),
                              ),
                              leading: Image.network(
                                bookmark[index]['imageUrl'],
                                fit: BoxFit.fill,
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () {
                                  bookmark.removeAt(index);
                                },
                              ),
                            ),
                          );
                  },
                )),
          ),
        ));
  }
}
