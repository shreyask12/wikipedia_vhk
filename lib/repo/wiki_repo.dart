import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vahakassignment/model/wiki_model.dart';

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
    // String searchUrl =
    //     'https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages|pageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpslimit=10&gpssearch=$title';

    var response = await http.get(
      Uri.parse(searchUrl + title),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(response.body);
      // WikiModel resData = WikiModel.fromJson(data);
      // return resData;
      return data;
    } else {
      print("Exception=======>");
      throw Exception();
    }
  }
}
