import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vahakassignment/cubit/wiki_links_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vahakassignment/model/wiki_model.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:vahakassignment/screens/showLinks.dart';

class ArticleLinksScreen extends StatefulWidget {
  const ArticleLinksScreen();

  @override
  _ArticleLinksScreenState createState() => _ArticleLinksScreenState();
}

class _ArticleLinksScreenState extends State<ArticleLinksScreen> {
  TextEditingController _searchController = TextEditingController();

  late WikiLinksCubit _wikiLinksCubit;
  late bool lastSearched;

  @override
  void initState() {
    super.initState();
    lastSearched = false;
    _wikiLinksCubit = context.read<WikiLinksCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wiki Links',
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
            sliver: SliverToBoxAdapter(
              child: TextField(
                  enabled: true,
                  autofocus: false,
                  controller: _searchController,
                  keyboardType: TextInputType.text,
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))
                  // ],
                  textCapitalization: TextCapitalization.sentences,
                  // onChanged: onSearchTextChanged,
                  onSubmitted: (String value) {
                    _wikiLinksCubit.getWikiLinksData(value);
                  },
                  onChanged: (String value) {
                    if (value.length > 3) {
                      EasyDebounce.debounce(
                          'searchwikilinks',
                          Duration(seconds: 2),
                          () => _wikiLinksCubit.getWikiLinksData(value));
                    }
                  },
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      filled: true,
                      fillColor: const Color(0xffF9FAFB),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: const Color(0xFFDCE5ED))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: const Color(0xFFDCE5ED))),
                      hintText: 'Search Links',
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(0.0),
                      ))),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10.0),
            sliver: SliverToBoxAdapter(
              child: BlocBuilder<WikiLinksCubit, WikiLinksState>(
                builder: (context, state) {
                  if (state is WikiLinksLoaded) {
                    return Text('Last Searched Results');
                  } else {
                    return Text('Search Results : ');
                  }
                },
              ),
            ),
          ),
          BlocConsumer<WikiLinksCubit, WikiLinksState>(
            listener: (context, state) {
              if (state is WikiLinksError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                    content: Text(state.message),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else if (state is WikiLinksLoaded) {
                FocusScope.of(context).unfocus();
              }
            },
            builder: (context, state) {
              if (state is WikiLinksLoading) {
                return SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                );
              } else if (state is WikiLinksError) {
                return SliverToBoxAdapter(
                    child: Container(child: Text(state.message)));
              } else if (state is WikiLinksLoaded) {
                List<Pages> model = state.model.query.pages;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ShowWikiLinksPage(
                                title: model[index].title,
                                pageId: model[index].pageid.toString(),
                              ),
                            ),
                          );
                        },
                        child: createCardView(model[index]));
                  }, childCount: state.model.query.pages.length),
                );
              } else {
                return SliverToBoxAdapter(child: Container());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget createCardView(Pages data) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) => ShowWikiLinksPage(
          //       title: data.title,
          //       pageId: data.pageid.toString(),
          //     ),
          //   ),
          // );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.15,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 1,
                child: data.thumbnail.source == ''
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 0.16,
                        child: Icon(Icons.error),
                      )
                    : CachedNetworkImage(
                        filterQuality: FilterQuality.high,
                        imageUrl: data.thumbnail.source,
                        imageBuilder: (context, imageProvider) => Container(
                          height: MediaQuery.of(context).size.height * 0.10,
                          width: MediaQuery.of(context).size.width * 0.16,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Container(
                            height: MediaQuery.of(context).size.height * 0.10,
                            width: MediaQuery.of(context).size.width * 0.16,
                            child: Center(child: Icon(Icons.error))),
                      ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        data.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text('Description : '),
                    Container(
                      child: Text(
                        data.terms.description[0],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
