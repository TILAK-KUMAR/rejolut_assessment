import 'package:flutter/material.dart';
import 'package:rejolut_assessment/Model/userImageModel.dart';
import 'package:rejolut_assessment/Utils/colors.dart';
import 'package:rejolut_assessment/Widgets/single_image.dart';

class UserPhotos extends StatelessWidget {

  final List<UserImageModel> photoList;
  const UserPhotos(this.photoList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.colorwhite,
        appBar: AppBar(

          backgroundColor: MyColors.toolbarBlue,
          elevation: 5.0,
          title: Text('Photos',
            style: TextStyle(fontSize: 20,color: MyColors.colorwhite,
                fontWeight: FontWeight.w400),),
        ),
        body: StreamBuilder(
          builder: (BuildContext context,AsyncSnapshot snapshot){

            return GridView.builder(
              itemCount: photoList.length,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0
                ),
                itemBuilder: (BuildContext context,int index){

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleImage(photoList[index].thumbnailUrl),
                        ), //MaterialPageRoute
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Image.network('${photoList[index].thumbnailUrl}',
                      fit: BoxFit.fill,height: 50,width: 50,),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 6,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                });

          },
        )
    );
  }
}
