import 'dart:convert';
import 'dart:developer';

import 'package:filter_listview_example/model/book.dart';
import 'package:http/http.dart' as http;

class BooksApi {
  BooksApi();
  static Future<List<Book>> getBooks(String query) async {
    final url =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed';
    // Uri.parse(
    // );
    final response = await http.get(Uri.parse(url));
    log("Url: " + url.toString());

    try {
      if (response.statusCode == 200) {
        log("API DAta: " + response.body);
        // final List<dynamic> books = json.decode(response.body);
        Map<String, dynamic> map = json.decode(response.body);
        final List<dynamic> books = map['results'];
        log("Json Data of api: " + books[0]['original_title']);

        return books.map((json) => Book.fromJson(json)).where((book) {
          final titleLower = book.original_title.toLowerCase();
          final authorLower = book.overview.toLowerCase();
          final searchLower = query.toLowerCase();

          return titleLower.contains(searchLower) ||
              authorLower.contains(searchLower);
        }).toList();
      }
    } catch (e) {
      log("Exception: " + e.toString());
    }
    throw Exception();
  }
}
