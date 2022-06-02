import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:listview/Firebase/cloud_firestore/firebase_data.dart';
import 'package:listview/Firebase/cloud_firestore/page_detail.dart';
import 'package:listview/Firebase/helpers/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:listview/Firebase/authentication/login_page.dart';

class PageSinhVien extends StatefulWidget {
  const PageSinhVien({Key? key}) : super(key: key);

  @override
  State<PageSinhVien> createState() => _PageSinhVienState();
}

class _PageSinhVienState extends State<PageSinhVien> {
  BuildContext? _dialogContext;
  @override
  Widget build(BuildContext context) {
    BuildContext _dialogContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Firebase App"),
        actions: [
          IconButton(onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PageDetail(xem: false,),)
          ),
            icon: const Icon(Icons.add_circle_outline,color: Colors.white,),
          )
        ],
      ),
      body: StreamBuilder<List<SinhVienSnapshot>>(
        stream: SinhVienSnapshot.getAllSinhVien(),
        builder: (context, snapshot){
          if(snapshot.hasError)
            return Center(child: Text(
              "Lỗi xảy ra khi truy vấn dữ liệu"
            ),);
          else
            if(!snapshot.hasData)
              return const Center(
                child: Text("Đang tải dữ liệu..."),
              );
            else
              return ListView.separated(
                  itemBuilder: (context, index) => Slidable(
                      child: ListTile(
                        leading: Text("${snapshot.data![index].sinhVien!.id}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        title: Text("${snapshot.data![index].sinhVien!.ten}"),
                        subtitle: Text("${snapshot.data![index].sinhVien!.lop}"),
                      ),
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) => Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) =>
                                    PageDetail(xem: true, svSnapshot: snapshot.data![index]))
                            ),
                            icon: Icons.details,
                            foregroundColor: Colors.green,
                          ),
                          SlidableAction(
                            onPressed: (context) => Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) =>
                                    PageDetail(xem: false, svSnapshot: snapshot.data![index]))
                            ),
                            icon: Icons.edit,
                            foregroundColor: Colors.blue,
                          ),
                          SlidableAction(
                            onPressed:(context)=> _xoa(_dialogContext, snapshot.data![index]),
                            icon: Icons.delete_forever,
                            foregroundColor: Colors.red,
                          ),
                        ],
                      ),
                  ),
                  separatorBuilder: (context, index) => const Divider(thickness: 1,),
                  itemCount: snapshot.data!.length,
              );
        },
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              Text('My firebase app'),
              ElevatedButton(onPressed: (){
                print('--------------------------------------------');
                print(FirebaseAuth.instance.currentUser?.email);
                FirebaseAuth.instance.signOut().whenComplete((){
                  print("đăng xuất thành công");
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LoginPage(),)
                      , (route) => false);
                  print('--------------------------------------------');
                  print(FirebaseAuth.instance.currentUser?.email);
                })
                    .catchError((e){
                  print('--------------------------------------------');
                  print(e);
                });

              },
                  child: Row(
                    children: const [
                      Icon(Icons.logout),
                      Text('Sign out')
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
  void _xoa(BuildContext context, SinhVienSnapshot svs) async {
    String? confirm;
    confirm = await showConfirmDialog(context, "Bạn muốn xóa ${svs.sinhVien!.ten} ?");
    if(confirm == "ok"){
      FirebaseStorage _storage = FirebaseStorage.instance;
      Reference reference = _storage.ref().child("images").child("anh_${svs.sinhVien!.id}.jpg");
      reference.delete();
      svs.delete().whenComplete(() => showSnackBar(context, "Xóa thành công", 3))
          .onError((error, stackTrace) {
        showSnackBar(context, "Xóa không thành công", 3);
        return Future.error("Xóa dữ liệu không thành công");
      });
    }
  }

}

