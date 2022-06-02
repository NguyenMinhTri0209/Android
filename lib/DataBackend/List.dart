import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Photo{
  late int albumId;
  late int id;
  late String title;
  late String url;
  late String thumbnailUrl;
  Photo({required this.albumId,required this.id,required this.title,required this.url,required this.thumbnailUrl});
  factory Photo.fromJson(Map<String, dynamic> json){
    return Photo(
        albumId : json['albumId'] as int,
        id : json['id'] as int,
        title : json['title'] as String,
        url : json['url'] as String,
        thumbnailUrl : json['thumbnailUrl'] as String);
  }
}

Future<List<Photo>> fetchPhotos() async{
  var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
  if(response.statusCode==200)
  {
    List<Photo> photos;
    var list = json.decode(response.body) as List;
    photos = list.map((item) => Photo.fromJson(item)).toList();return photos;
  }
  else{
    print("Không tải được Album");
    throw Exception("Khong tai duoc Album");
  }
}

class PhotoList extends StatelessWidget {
  List<Photo> photos;
  PhotoList({Key? key, required this.photos}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 200, padding: EdgeInsets.all((5)),mainAxisSpacing: 5, crossAxisSpacing: 5,
      children: List.generate(photos.length, (index) => Container(decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
      ),
        child: Image.network(photos[index].thumbnailUrl),)),
    );
  }
}

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  late Future<List<Photo>> photos;
  void initState(){
    super.initState();
    photos = fetchPhotos();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Photo>>(
        future: photos,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            print("Lỗi xảy ra");
            return Text("Lỗi xảy ra");
          }
          return snapshot.hasData
              ? PhotoList(photos: snapshot.data!)
              : Center(child: CircularProgressIndicator(),);},
      ),
    );
  }
}





