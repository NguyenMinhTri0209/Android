


import 'package:listview/express_news/list_news.dart';
import 'package:listview/express_news/rss_helper.dart';
import 'package:listview/express_news/ssr_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<RSSItem>?> rssItems;
  @override
  void initState(){
    super.initState();
    rssItems = RSSHelper.readVNExpressRSS();
  }
  Widget getImage(String? url){
    if(url!=null) {
      return Image.network(url, fit: BoxFit.fitWidth,);
    }
    return const Center(
      child: Icon(Icons.image),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Express news"),
        leading: const Icon(Icons.menu),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: ()async {
            await Future.delayed(const Duration(milliseconds: 1500));
            rssItems = RSSHelper.readVNExpressRSS().whenComplete(() => setState((){}));
          },
          child:
            FutureBuilder<List<RSSItem>?>(
                  future: rssItems,
                  builder: (context,snapshot)
                  {
                    if(snapshot.hasError) {
                      Text("Error");
                    }
                    return snapshot.hasData ?
                        ListNews(list: snapshot.data!)
                        : const Center(
                      child: CircularProgressIndicator(),
                    );

                  },)
      ),
        ),
      );
  }

  Widget BuildNewsPage(RSSItem e) {
    return Card();
  }


}



