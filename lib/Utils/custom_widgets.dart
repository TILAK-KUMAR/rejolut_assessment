
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';

class ConstantWidgets{

  showAlertDialog(BuildContext context, int i) {
    // Create button

    if(i==0){
      AlertDialog alert = AlertDialog(

        title: Text('Loading'),
        content: Text(' Please wait...',style: TextStyle(
          fontSize: 16
        ),textAlign: TextAlign.center,),
      );

      // show the dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    else{
      Navigator.of(context).pop();
    }

    // Create AlertDialog

  }


  showToast(String message){

    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: MyColors.colorwhite,
        fontSize: 16.0
    );
  }
}

