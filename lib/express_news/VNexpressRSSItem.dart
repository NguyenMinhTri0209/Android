

import 'package:listview/express_news/ssr_item.dart';

class VNExpressRSSItem extends RSSItem {




  @override
  String getDescription(String rawDescription) {
    int start = rawDescription.indexOf('</a></br>')+9;
    if (start > 9) {
      return rawDescription.substring(start);
    }
    return "";
  }

  @override
  String getImageUrl(String rawDescription) {
    int start = rawDescription.indexOf('img src="')+9;
    if (start> 9) {
      int end = rawDescription.indexOf('"', start);
      return rawDescription.substring(start, end);

    }
    return "";
  }
}
