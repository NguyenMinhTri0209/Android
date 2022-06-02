import 'package:flutter/material.dart';

void cshowSnakBar(BuildContext context, String content){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(seconds: 10),
      ));
}

class SlideImg extends StatefulWidget {
  const SlideImg({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<SlideImg> createState() => _SlideImgState();
}

class _SlideImgState extends State<SlideImg> {
  int _counter = 1;

  void countNext() {
    print("Phải");
    setState(() {
      if(_counter<5)
        _counter++;
    });
    print('$_counter');
  }

  void countBefore() {
    print("Trái");
    setState(() {
      if(_counter>1)
        _counter--;
    });

    print('$_counter');
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the SlideImg object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Kiệt Kun"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 250,
                child: Image.asset("img/$_counter.jpg"),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(150.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: countBefore,
                child: Icon(Icons.navigate_before),
              ),
              ElevatedButton(
                onPressed: countNext,
                child: Icon(Icons.navigate_next),
              )
            ],
          ),
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
