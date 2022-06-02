import 'ListSP.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ListProduct extends StatelessWidget {
  ListProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListSP(),
      child: Consumer<ListSP>(
        builder: (context, List, child) => Scaffold(
          appBar: AppBar(
            title: Text("Danh sách sản phẩm"),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.white,
                ),
                onPressed: () {
                  List.themDialog(context);
                },
              )
            ],
          ),
          body: ListView.separated(
              itemCount: List.size,
              itemBuilder: (context,i){
                return (
                    Slidable(
                      // Specify a key if the Slidable is dismissible.
                        key: const ValueKey(0),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) => List.xoaDialog(context, i),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.restore_from_trash,
                              label: 'Xóa',
                            ),
                            SlidableAction(
                              onPressed: (context) => List.suaDialog(context, i),
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Chỉnh sửa',
                            ),
                            SlidableAction(
                              onPressed: (context) => List.hienThiDialong(context, i),
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              icon: Icons.remove_red_eye_outlined,
                              label: 'Xem',
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Icon(Icons.shopping_cart,color: Colors.blue,),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  List.getTen(i)!,
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text(
                                List.getLoai(i)!,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          trailing: Text(List.getGia(i)!+".0"),
                        )
                    )
                );
              }, separatorBuilder: (BuildContext context, int index) => Divider(thickness: 2,),
          ),
          ),
      ),
    );
  }

}

