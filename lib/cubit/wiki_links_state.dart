// import 'dart:convert';

// import 'package:equatable/equatable.dart';

part of 'wiki_links_cubit.dart';

abstract class WikiLinksState extends Equatable {
  const WikiLinksState();

  @override
  List<Object> get props => [];
}

class WikiLinksInitial extends WikiLinksState {
  const WikiLinksInitial();
  @override
  List<Object> get props => [];
}

class WikiLinksLoading extends WikiLinksState {
  const WikiLinksLoading();
  @override
  List<Object> get props => [];
}

class WikiLinksLoaded extends WikiLinksState {
  final WikiModel model;
  const WikiLinksLoaded({
    required this.model,
  });
  @override
  List<Object> get props => [model];

  WikiLinksLoaded copyWith({
    WikiModel? model,
  }) {
    return WikiLinksLoaded(
      model: model ?? this.model,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model.toJson(),
    };
  }

  factory WikiLinksLoaded.fromMap(Map<String, dynamic> map) {
    return WikiLinksLoaded(
      model: WikiModel.fromJson(map['model']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WikiLinksLoaded.fromJson(String source) =>
      WikiLinksLoaded.fromMap(json.decode(source));

  @override
  String toString() => 'WikiLinksLoaded(model: $model)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WikiLinksLoaded && other.model == model;
  }

  @override
  int get hashCode => model.hashCode;
}

class WikiLinksError extends WikiLinksState {
  final String message;
  const WikiLinksError(this.message);
  @override
  List<Object> get props => [message];
}
