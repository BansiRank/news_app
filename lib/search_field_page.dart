import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/description_page.dart';

List<Map<String, dynamic>> jsonList = [];

class MySearchField extends StatefulWidget {
  const MySearchField({Key? key}) : super(key: key);

  @override
  MySearchFieldState createState() => MySearchFieldState();
}

ScrollController scrollController = ScrollController();

class MySearchFieldState extends State<MySearchField> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isTextFieldEnable = true;
  final FocusNode _focusNode = FocusNode();
  bool _showSuggestions = false;
  dynamic _suggestions = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: const Text('Search'),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                _focusNode.unfocus();
              },
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                    prefixIcon: IconButton(
                      onPressed: () {
                        _focusNode.requestFocus();
                        FocusScope.of(context).requestFocus(_focusNode);
                      },
                      icon: const Icon(Icons.search),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          _textEditingController.clear();
                        },
                        icon: const Icon(Icons.close))),
                controller: _textEditingController,
                onChanged: _onTextChanged,
                focusNode: _focusNode,
                readOnly: isTextFieldEnable,
              ),
            ),
            if (_showSuggestions)
              ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                itemCount: _suggestions.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = jsonList[index];
                  return ListTile(
                    leading: Image.network(jsonList[index]['imageUrl']),
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(_suggestions[index]),
                    onTap: () {
                      // _textEditingController.text = _suggestions[index];
                      setState(() {
                        _showSuggestions = false;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                      id: item,
                                    )));
                      });
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  void _onTextChanged(String value) {
    setState(() {
      _suggestions = jsonList
          .where((item) =>
              item['title'].toLowerCase().contains(value.toLowerCase()))
          .map<String>((item) => item['title'] as String)
          .toList();
      _showSuggestions = _suggestions.isNotEmpty;
    });
  }

  Future<void> getData() async {
    try {
      var response = await Dio().get('https://inshorts.deta.dev/news?category');
      if (response.statusCode == 200) {
        setState(() {
          jsonList = List<Map<String, dynamic>>.from(response.data['data']);
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }
}
