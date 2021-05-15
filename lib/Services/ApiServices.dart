import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rejolut_assessment/Model/userAlbumModel.dart';
import 'package:rejolut_assessment/Model/userDetailsModel.dart';
import 'package:rejolut_assessment/Model/userImageModel.dart';
import 'dart:convert';
import 'dart:async';

import 'package:rejolut_assessment/Utils/constants.dart';


class ApiServices{


  Future<UserDetailsModel> getUserDetails(String userID) async{

    Response response = await http.get('${Constants.baseURL}/users/${userID}');
    if(response.statusCode == 200){

      print('this is userDetails URL : ${Constants.baseURL}/users/${userID}');
      print('this is userDetails : ${response.body}');
      return UserDetailsModel.fromJson(json.decode(response.body));

    }

    else{
     return null;
    }

  }

   getAlbums(String userID) async{
    List<UserAlbumModel> userAlbums = [];

    Response response = await http.get('${Constants.baseURL}/albums?userId=${userID}');
    if(response.statusCode == 200){
      // UserAlbumModel albumModel = UserAlbumModel.fromJson(json.decode(response.body));

      final data = jsonDecode(response.body);
      for (Map<String,dynamic> u in data){
        UserAlbumModel albums = UserAlbumModel.fromJson(u);
        userAlbums.add(albums);
      }
      return userAlbums;
    }

    else{
      return null;
    }
  }

  getPhotos(String userID) async{
    List<UserImageModel> photos = [];

    Response response = await http.get('${Constants.baseURL}/photos?albumId=${userID}');
    if(response.statusCode == 200){
      // UserAlbumModel albumModel = UserAlbumModel.fromJson(json.decode(response.body));

      final data = jsonDecode(response.body);
      for (Map<String,dynamic> u in data){
        UserImageModel albums = UserImageModel.fromJson(u);
        photos.add(albums);
      }
      return photos;
    }

    else{
      return null;
    }
  }

}