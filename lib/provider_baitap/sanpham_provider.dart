import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'sanpham_list.dart';

class SanPham{
  late String ten;
  late String ct;
  late double gia;
  SanPham({required this.ten, required this.ct, required this.gia});
}
class QLSanPham extends ChangeNotifier{
  late List<SanPham> _list;
  List<SanPham> get list => _list;
  void delete(int index){
    _list.removeAt(index);
    notifyListeners();
  }
  void update (SanPham moi, SanPham cu){
    //Gan tung thuoc tinh cu vao moi
    notifyListeners();
  }
}

QLSanPham sp = QLSanPham();
class SPapp extends StatelessWidget {
  const SPapp({Key? key}) : super(key: key);

  @override
  Widget _buildRow(SanPham sp,IconData icon){
    return new ListTile(
      title: Text(sp.ten,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),),
      subtitle: Text(sp.ct,style: TextStyle(fontSize: 15,)),
      leading: Icon(icon,
        color: Colors.blue[500],
      ),
      trailing: Text("Giá: ${sp.gia}đ", style: TextStyle(color: Colors.red),),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Danh sách Sản Phẩm")
        ),
        body: ListView.separated(
            itemCount: listSP.length,
            itemBuilder: (context, index)
            {
              //_buildRow(listSP[index], Icons.shopping_cart_sharp);
              return Slidable(
                // Specify a key if the Slidable is dismissible.
                key: const ValueKey(0),
                // The end action pane is the one at the right or the bottom side.
                endActionPane: const ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: null,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Xóa',
                    ),
                    SlidableAction(
                      onPressed: null,
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      icon: Icons.addchart_outlined,
                      label: 'Cập nhập',
                    ),
                    SlidableAction(
                      onPressed: null,
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.visibility,
                      label: 'Xem',
                    ),
                  ],
                ),
                child: _buildRow(listSP[index], Icons.shopping_cart_sharp),
                // The child of the Slidable is what the user sees when the
                // component is not dragged.

              );
            }, separatorBuilder: (BuildContext context, int index) =>  Divider(thickness: 2,) ,
        )
      );
  }
}
