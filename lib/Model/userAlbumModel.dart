import 'dart:convert';


List<UserAlbumModel> albumFromJson(String str) =>
    List<UserAlbumModel>.from(json.decode(str).map((x) => UserAlbumModel.fromJson(x)));


class UserAlbumModel {
  int userId;
  int id;
  String title;

  UserAlbumModel({this.userId, this.id, this.title});

  factory UserAlbumModel.fromJson(Map<String, dynamic> json) {
   return UserAlbumModel(
     userId: json['userId'],
     id: json['id'],
     title: json['title']
   );
  }


}