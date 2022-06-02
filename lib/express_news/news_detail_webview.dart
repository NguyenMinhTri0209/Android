

import 'package:listview/express_news/ssr_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailWebView extends StatelessWidget {
  RSSItem news;
  NewsDetailWebView({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: news.link!,
    );
  }
}
