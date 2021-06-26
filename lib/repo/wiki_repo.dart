import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class WikiLinksRepository {
  Future<dynamic> wikiLinksgetData({
    @required title,
  });
}

class WikiLinksRepoIml extends WikiLinksRepository {
  static const searchUrl =
      'https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages|pageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpslimit=10&gpssearch=';

  @override
  Future wikiLinksgetData({
    title,
  }) async {
    var response = await http.get(
      Uri.parse(searchUrl + title),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return data;
    } else {
      print("Exception=======>");
      throw Exception();
    }
  }
}
