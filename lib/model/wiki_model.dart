class WikiModel {
  late Query query;

  WikiModel({required this.query});

  WikiModel.fromJson(Map<String, dynamic> json) {
    query = (json['query'] != null ? new Query.fromJson(json['query']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['query'] = this.query.toJson();

    return data;
  }
}

class Query {
  late List<Pages> pages;

  Query({required this.pages});

  Query.fromJson(Map<String, dynamic> json) {
    // if (json['redirects'] != null) {
    //   redirects = [];
    //   json['redirects'].forEach((v) {
    //     redirects.add(new Redirects.fromJson(v));
    //   });
    // }
    if (json['pages'] != null) {
      pages = [];
      json['pages'].forEach((v) {
        pages.add(new Pages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    // data['redirects'] = this.redirects.map((v) => v.toJson()).toList();

    data['pages'] = this.pages.map((v) => v.toJson()).toList();

    return data;
  }
}

// class Redirects {
//   late int index;
//   late String from;
//   late String to;

//   Redirects({required this.index, required this.from, required this.to});

//   Redirects.fromJson(Map<String, dynamic> json) {
//     index = json['index'];
//     from = json['from'];
//     to = json['to'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['index'] = this.index;
//     data['from'] = this.from;
//     data['to'] = this.to;
//     return data;
//   }
// }

class Pages {
  late int pageid;
  late int ns;
  late String title;
  late int index;
  late Thumbnail thumbnail;
  late Terms terms;

  Pages(
      {required this.pageid,
      required this.ns,
      required this.title,
      required this.index,
      required this.thumbnail,
      required this.terms});

  Pages.fromJson(Map<String, dynamic> json) {
    pageid = json['pageid'];
    ns = json['ns'];
    title = json['title'];
    index = json['index'];
    thumbnail = (json['thumbnail'] != null
            ? new Thumbnail.fromJson(json['thumbnail'])
            : null) ??
        Thumbnail(height: 50, source: '', width: 50);
    terms =
        (json['terms'] != null ? new Terms.fromJson(json['terms']) : null) ??
            Terms(description: []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageid'] = this.pageid;
    data['ns'] = this.ns;
    data['title'] = this.title;
    data['index'] = this.index;
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }
    if (this.terms != null) {
      data['terms'] = this.terms.toJson();
    }
    return data;
  }
}

class Thumbnail {
  late String source;
  late int width;
  late int height;

  Thumbnail({required this.source, required this.width, required this.height});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Terms {
  late List<String> description;

  Terms({required this.description});

  Terms.fromJson(Map<String, dynamic> json) {
    description = json['description'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    return data;
  }
}
