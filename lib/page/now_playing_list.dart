import 'dart:async';
import 'dart:developer';

import 'package:filter_listview_example/api/now_playing.dart';
import 'package:filter_listview_example/main.dart';
import 'package:filter_listview_example/model/book.dart';
import 'package:filter_listview_example/page/navigation_page.dart';
import 'package:filter_listview_example/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterLocalListPage extends StatefulWidget {
  @override
  FilterLocalListPageState createState() => FilterLocalListPageState();
}

class FilterLocalListPageState extends State<FilterLocalListPage> {
  List<Book> books = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final books = await BooksApi.getBooks(query);

    setState(() => this.books = books);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Now Playing'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  var book = books[index];
                  return Dismissible(
                      onDismissed: (direction) {
                        setState(() {
                          books.removeAt(index);
                        });
                      },
                      key: Key(book.id.toString()),
                      child: buildBook(book));
                  // return buildBook(book);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final books = await BooksApi.getBooks(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.books = books;
        });
      });

  // void navigate() {}

  Widget buildBook(Book book) {
    return ListTile(
        tileColor: Colors.amber[300],
        leading: Image.network(
          'https://image.tmdb.org/t/p/w342' + book.backdrop_path,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
        title: Text(book.original_title),
        subtitle: Text(book.overview),
        // trailing: GestureDetector(
        //     onTap: () {
        //       log("Delete");
        //     },
        //     child: Icon(Icons.delete)),
        onTap: () {
          Get.to(() => NavigationPage(
                url: 'https://image.tmdb.org/t/p/w342' + book.backdrop_path,
                title: book.original_title,
                content: book.overview,
                releaseDate: book.release_date,
              ));
        });
  }
}
