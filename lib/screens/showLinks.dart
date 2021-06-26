import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowWikiLinksPage extends StatefulWidget {
  final String pageId;
  final String title;
  const ShowWikiLinksPage({Key? key, required this.title, required this.pageId})
      : super(key: key);

  @override
  _ShowWikiLinksPageState createState() => _ShowWikiLinksPageState();
}

class _ShowWikiLinksPageState extends State<ShowWikiLinksPage> {
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              WebView(
                onPageFinished: (_) {
                  setState(() {
                    isLoading = false;
                  });
                },
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: "https://en.wikipedia.org/?curid=" + widget.pageId,
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
