import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import 'my_provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Counter counter = Provider.of<Counter>(context,listen: true);
    return Scaffold(
      appBar: AppBar(title: Text("Provider Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Số lần bạn đã bấm trên button :"),
            FutureBuilder<int>(
              initialData: 0,
              future:counter.getValue(),
              builder:(context,snapshot){
                return Text("${snapshot.data}",style: TextStyle(fontSize: 40),);
              }

            )
          ],
        ),
      ),

      floatingActionButton: IconButton(
        icon: Icon(Icons.add_circle, color: Colors.green, size: 50,),
        onPressed: (){
          var provider = context.read<Counter>();
          provider.incremnt();
        },
      ),
    );

  }
}
