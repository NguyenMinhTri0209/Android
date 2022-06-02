import 'package:flutter/material.dart';

class Count extends StatefulWidget {
  const Count({Key? key}) : super(key: key);

  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<Count> {
  int _counter = 0;
  void countUp() {
    print("Pushed counter up");
    setState(() {
      _counter++;
    });
    print('$_counter');
  }

  void countDown() {
    print("Pushed counter down");
    setState(() {
      _counter--;
    });

    print('$_counter');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: countUp,
              child: const Icon(Icons.add),
            ),
            Text(
              '$_counter',
              style: const TextStyle(color: Colors.green, fontSize: 40),
            ),
            ElevatedButton(
              onPressed: countDown,
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}