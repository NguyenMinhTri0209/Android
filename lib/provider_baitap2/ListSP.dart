import 'SP_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ListSP extends ChangeNotifier{

  List<SP> _SPs = List.generate(t.length, (i) {
    SP s = new SP();
    s.ten = t[i];
    s.loai = l[i];
    s.gia = g[i];
    return s;
  },);

  int get size => _SPs.length;
  bool hienthi = false;

  String? getTen(int i) => _SPs[i].ten;
  String? getLoai(int i) => _SPs[i].loai;
  String? getGia(int i) => _SPs[i].gia.toString();

  void Xoa(int i){
    _SPs.removeAt(i);
    notifyListeners();
  }

  void Them(BuildContext context,SP m){
    _SPs.add(m);
    Navigator.of(context).pop();
    notifyListeners();
  }

  void sua(BuildContext context,int i, SP s) {
    _SPs[i].ten = s.ten;
    _SPs[i].gia = s.gia;
    _SPs[i].loai = s.loai;
    Navigator.of(context).pop();
    notifyListeners();
  }

  Future themDialog(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey<FormState>();
    SP m = SP();
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Thêm sản phẩm",style: TextStyle(fontWeight: FontWeight.bold)),
          content: Form(
            key: formState,
            autovalidateMode: AutovalidateMode.disabled,
            child: Container(
              height: 250,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (newValue) => m.ten = newValue,
                    validator: (value) => validateString(value),
                    decoration: const InputDecoration(
                        labelText: "Tên sản phẩm"
                    ),
                  ),
                  TextFormField(
                    onSaved: (newValue) => m.loai = newValue,
                    validator: (value) => validateString(value),
                    decoration: const InputDecoration(
                        labelText: "Loại sản phẩm"
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) => m.gia = double.parse(newValue!),
                    validator: (value) => validateGia(value),
                    decoration: const InputDecoration(
                        labelText: "Giá sản phẩm"
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  if(formState.currentState!.validate()){
                    formState.currentState!.save();
                    Them(context,m);
                  }
              },
                child: Text("OK"),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.blue,
                )
            )
          ],
        )
    );
  }

  Future hienThiDialong(BuildContext context,int i) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Chi tiết sản phẩm", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Container(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Tên sản phẩm: ${_SPs[i].ten}"),
                Text("Loại sản phẩm: ${_SPs[i].loai}"),
                Text("Giá: ${_SPs[i].gia}đ"),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK"),
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.blue,
                )
            )
          ],
        )
    );
  }

  Future suaDialog(BuildContext context, int i) {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  SP m = SP();
  return showDialog(
      context: context,
      builder: (context)=>AlertDialog(
      title: Text("Chỉnh sửa"),
      content: Form(
      key: formState,
      autovalidateMode: AutovalidateMode.disabled,
      child: Container(
        height: 250,
        child: Column(
          children: [
            TextFormField(
              initialValue: _SPs[i].ten,
              onSaved: (newValue) => m.ten = newValue,
              validator: (value) => validateString(value),
              decoration: InputDecoration(
                  labelText: "Tên mặt hàng"
              ),
            ),
            TextFormField(
              initialValue: _SPs[i].loai,
              onSaved: (newValue) => m.loai = newValue,
              validator: (value) => validateString(value),
              decoration: InputDecoration(
                  labelText: "Loại"
              ),
            ),
            TextFormField(
              initialValue: _SPs[i].gia.toString(),
              keyboardType: TextInputType.number,
              onSaved: (newValue) => m.gia = double.parse(newValue!),
              validator: (value) => validateGia(value),
              decoration: InputDecoration(
                  labelText: "Giá"
              ),
            ),
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
          onPressed: () {
            if(formState.currentState!.validate()){
              formState.currentState!.save();
              sua(context,i,m);
            }
          },
          child: Text("OK"),
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: Colors.blue,
          )
      )
    ],
      )
  );
}

  Future xoaDialog(BuildContext context, int i) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Bạn có chắc chắn muốn xóa?",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: (){
              Xoa(i);
              Navigator.of(context).pop();
            }, child: Text("Yes")),
            ElevatedButton(
              child: Text("No"),
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Colors.red,
                onSurface: Colors.red,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      )
  );
}

  validateString(String? value) {
    return value == null || value.isEmpty ? "Bạn chưa nhập dữ liệu" : null;
  }

  validateGia(String? value) {
    if(value == null || value.isEmpty)
      return "Bạn chưa nhập giá";
    else
      return int.parse(value)<0 ? "Giá không được phép bé hơn 0" : null;
  }

}



