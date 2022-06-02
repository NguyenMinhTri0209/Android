import 'package:flutter/material.dart';
import 'package:listview/provider/my_provider.dart';
import 'package:provider/provider.dart';

import 'counter_page.dart';

class MyProviderApp extends StatelessWidget {
  const MyProviderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Counter(),
        child: const CounterPage()
    );
  }
}
