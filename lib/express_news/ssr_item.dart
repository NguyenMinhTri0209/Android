

import 'package:listview/express_news/VNexpressRSSItem.dart';

abstract class RSSItem {
  String? title;
  String? pubDate;
  String? description;
  String? link;
  String? imageUrl;

  Map<String, dynamic> toJson(){
    return {
      "title": title,
      "pubDate": pubDate,
      "description": description,
      "link": link,
      "imageUrl": imageUrl,
    };
  }

  RSSItem getRSSFromJson(Map<String, dynamic> json){
      title = json['title'];
      pubDate = json['pubDate'];
      description = json['description'];
      link = json['link'];
      imageUrl = json['imageUrl'];
    return this;
  }



  String? getDescription(String rawDescription);
  String getImageUrl(String rawDescription);



}