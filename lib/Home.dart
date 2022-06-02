import 'package:flutter/material.dart';
import 'package:listview/Firebase/cloud_firestore/page_firebase_app.dart';
import 'package:listview/coban/count.dart';
import 'package:listview/express_news/NewsPage.dart';
import 'package:listview/provider_baitap/sanpham_provider.dart';
import 'package:listview/slideimg/slideanh.dart';
import 'list/List.dart';
import 'form/page_mathang.dart';
import 'provider/my_app.dart';
import 'provider_baitap2/DSSP.dart';
import 'DataBackend/List.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kiệt Kun"),
      ),
      body: Center(
          child: Column(
            children: [
              buttonBuider(context, title: "Đếm", destination: Count()),
              buttonBuider(context, title: "Slide ảnh", destination: SlideImg()),
              buttonBuider(context, title: "Form", destination: PageFormMatHang()),
              buttonBuider(context, title: "List", destination: GristView()),
              buttonBuider(context, title: "Provider", destination: MyProviderApp()),
              buttonBuider(context, title: "Sản phẩm", destination: SPapp()),
              buttonBuider(context, title: "Sản phẩm 2", destination: ListProduct()),
              buttonBuider(context, title: "List Ảnh", destination: PhotosPage()),
              buttonBuider(context, title: "Tạp chí", destination: NewsPage()),
              buttonBuider(context, title: "My Firebase App", destination: MyFirebaseApp())
            ]
          )
      ),
    );
  }
  Widget buttonBuider(BuildContext context,{required String title, required Widget destination})
  {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: 120.0,
        child: ElevatedButton(onPressed:() =>
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => destination,)
            ),
          child: Text(title),
        ),
      ),
    );
  }

}
