class ErrorModel {
  late Error error;
  late String servedby;

  ErrorModel({
    required this.error,
    required this.servedby,
  });

  ErrorModel.fromJson(Map<String, dynamic> json) {
    error = Error.fromJson(json['error']);
    servedby = json['servedby'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error.toJson();
    _data['servedby'] = servedby;
    return _data;
  }
}

class Error {
  late String code;
  late String info;
  late String docref;

  Error({
    required this.code,
    required this.info,
    required this.docref,
  });

  Error.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    info = json['info'];
    docref = json['docref'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['info'] = info;
    _data['docref'] = docref;
    return _data;
  }
}
