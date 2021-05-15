import 'package:flutter/material.dart';
import 'package:rejolut_assessment/Utils/colors.dart';

class SingleImage extends StatelessWidget {

  String imageUrl;
  SingleImage(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: MyColors.toolbarBlue,
        title: Text('Single Photo',style: TextStyle(fontSize: 20,color: MyColors.colorwhite,
            fontWeight: FontWeight.w400),),),
      body: Image.network('${imageUrl}',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,),
      );
  }
}
