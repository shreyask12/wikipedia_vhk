import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:vahakassignment/model/error_model.dart';
import 'package:vahakassignment/model/wiki_model.dart';
import 'package:vahakassignment/repo/wiki_repo.dart';
import 'dart:convert';

part 'wiki_links_state.dart';

class WikiLinksCubit extends Cubit<WikiLinksState> with HydratedMixin {
  final WikiLinksRepoIml _wikirepo;
  WikiLinksCubit(this._wikirepo) : super(WikiLinksInitial()) {
    hydrate();
  }

  getWikiLinksData(String title) async {
    emit(WikiLinksLoading());

    try {
      var data = await _wikirepo.wikiLinksgetData(title: title);
      if (data.containsKey('error')) {
        ErrorModel error = ErrorModel.fromJson(data);
        emit(WikiLinksError(error.error.code.toString()));
      } else {
        WikiModel model = WikiModel.fromJson(data);
        refreshState(model);
      }
    } catch (e) {
      emit(WikiLinksError(e.toString()));
    }
  }

  refreshState(WikiModel model) {
    WikiModel newModel;
    newModel = model;
    emit(WikiLinksLoaded(model: newModel));
  }

  @override
  WikiLinksState? fromJson(Map<String, dynamic> json) {
    try {
      return WikiLinksLoaded.fromMap(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(WikiLinksState state) {
    if (state is WikiLinksLoaded) {
      return state.toMap();
    }
  }
}
