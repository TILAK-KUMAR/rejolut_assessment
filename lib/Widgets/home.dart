import 'package:flutter/material.dart';
import 'package:rejolut_assessment/Model/userAlbumModel.dart';
import 'package:rejolut_assessment/Model/userImageModel.dart';
import 'package:rejolut_assessment/Services/ApiServices.dart';
import 'package:rejolut_assessment/Utils/colors.dart';
import 'package:rejolut_assessment/Utils/custom_widgets.dart';
import 'package:rejolut_assessment/Widgets/user_photos.dart';

class Home extends StatelessWidget {
  final String username;
  final String userId;
  final List<UserAlbumModel> albumList;
  const Home(this.username,this.userId,this.albumList);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyColors.colorwhite,
      appBar: AppBar(

        backgroundColor: MyColors.toolbarBlue,
        elevation: 5.0,
        leading: Container(),
        title: Text('Hello ${username}',
          style: TextStyle(fontSize: 20,color: MyColors.colorwhite,
              fontWeight: FontWeight.w400),),
      ),
      body: StreamBuilder(
        builder: (BuildContext context,AsyncSnapshot snapshot){

          return ListView.builder(
            itemCount: albumList.length,

              itemBuilder: (BuildContext context,int index){
              return Padding(
                padding: const EdgeInsets.only(top:8.0,right: 12.0,left: 12.0),
                child: GestureDetector(
                  onTap: (){
                    ConstantWidgets().showAlertDialog(context, 0);
                    getMyPhotos(context,albumList[index].id.toString());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: MyColors.darkBlue
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${albumList[index].title}',
                              style: TextStyle(fontSize: 20,color: MyColors.colorwhite,
                                  fontWeight: FontWeight.w100)),
                        ],
                      )
                    ),
                  ),
                ),
              );

          });

        },
      )
    );
  }


  getMyPhotos(BuildContext context,String AlbumId)async {
    List<UserImageModel> imageModel = await ApiServices().getPhotos(AlbumId);
    if(imageModel!=null){
      ConstantWidgets().showAlertDialog(context, 1);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserPhotos(imageModel),
        ), //MaterialPageRoute
      );
    }
    else{
      ConstantWidgets().showAlertDialog(context, 1);
      ConstantWidgets().showToast('Unable to Fetch Photos. Please try again later');
    }

  }

}
