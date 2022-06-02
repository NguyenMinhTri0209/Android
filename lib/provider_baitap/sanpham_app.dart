import 'package:flutter/material.dart';
import 'sanpham_list.dart';
import 'sanpham_provider.dart';
import 'package:provider/provider.dart';

class SanPhamApp extends StatelessWidget {
  const SanPhamApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QLSanPham(),
      child: (SPapp()),
    );
  }
}
