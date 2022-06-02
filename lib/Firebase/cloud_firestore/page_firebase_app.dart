import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'page_home_firebase_app.dart';

class MyFirebaseApp extends StatefulWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  @override
  State<MyFirebaseApp> createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  bool ketNoi = false;
  bool loi = false;
  @override
  Widget build(BuildContext context) {
    if(loi)
      return Container(
          color: Colors.white,
          child: Center(
            child: Text("Có lỗi xảy ra",
              style: TextStyle(fontSize: 18,),
              textDirection: TextDirection.ltr,
            ),
          ),
        );
    else
      if(!ketNoi)
        return Container(
            color: Colors.white,
            child: Center(
              child: Text("Đang kết nối...",
                style: TextStyle(fontSize: 18,),
                textDirection: TextDirection.ltr,
              ),
            ),
          );
      else
        return MaterialApp(
              title: "Kết nối Firebase",
              home: PageSinhVien(),
            );
  }

  @override
  void initState() {
    super.initState();
    _khoiTaoFirebase();
  }

  _khoiTaoFirebase() async{
    try{
      await Firebase.initializeApp();
      setState(() {
        ketNoi = true;
      });
    }catch(e){
      setState(() {
        loi = true;
      });
    }
  }
}
