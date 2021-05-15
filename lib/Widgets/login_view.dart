import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rejolut_assessment/Model/userAlbumModel.dart';
import 'package:rejolut_assessment/Model/userDetailsModel.dart';
import 'package:rejolut_assessment/Services/ApiServices.dart';
import 'package:rejolut_assessment/Utils/colors.dart';
import 'package:rejolut_assessment/Utils/constants.dart';
import 'package:rejolut_assessment/Utils/custom_widgets.dart';
import 'package:rejolut_assessment/Widgets/home.dart';

class Login extends StatelessWidget {
   List<UserAlbumModel> albums;

   TextEditingController emailCntrl = TextEditingController();
   TextEditingController passwordCtrl = TextEditingController();
   GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.colorwhite,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: MyColors.colorwhite,
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: ()=> FocusScope.of(context).requestFocus(new FocusNode()),
          child: StreamBuilder(
            builder: (BuildContext context,AsyncSnapshot snapshot){

              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:20.0),
                    child: Text('${Constants.login}',style: TextStyle(
                      fontSize: 32,color: MyColors.darkBlue,fontWeight: FontWeight.bold
                    ),textAlign: TextAlign.center,),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:32.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            // validator: (value){
                            //   if(value.isEmpty){
                            //     return Constants.email_error_text;
                            //   }
                            //   else{
                            //     return null;
                            //   }
                            // },
                            controller:emailCntrl,
                            style: TextStyle(color: MyColors.colorBlack),
                            cursorColor: MyColors.darkBlue,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500])),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500])),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.colorBlack)),
                                hintText: Constants.email_hint,
                                hintStyle: TextStyle(color: Colors.grey[500])
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          TextFormField(
                            // validator: (value){
                            //   if(value.isEmpty){
                            //     return Constants.password_error_text;
                            //   }
                            //   else{
                            //     return null;
                            //   }
                            // },
                            controller: passwordCtrl,
                            style: TextStyle(color:MyColors.colorBlack),
                            obscureText: true,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500])),
                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500])),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.colorBlack)),
                                hintText: Constants.password_hint,
                                hintStyle: TextStyle(color: Colors.grey[500])
                            ),
                          ),
                          SizedBox(
                            height: 48,
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              color: MyColors.buttonColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                ConstantWidgets().showAlertDialog(context, 0);
                                validateCred(context);
                              },
                              child: Text('${Constants.login}',style: TextStyle(
                                color: MyColors.colorwhite,fontSize: 18
                              ),),
                            ),
                          )

                        ],
                      ),
                    ),
                  )
                ],
              );

            },
          ),
        ),
      )
    );
  }

  Future<void> validateCred(BuildContext context)async{
    String emailId = emailCntrl.value.text;
    String password = passwordCtrl.value.text;

    if(validateEmail(emailId)){
      String userId = emailId.substring(0,emailId.indexOf('@'));


      if(validatePassword(password)){

        UserDetailsModel userDetailsModel = await ApiServices().getUserDetails(userId.length.toString());
        if(userDetailsModel!=null){



          List<UserAlbumModel> userAlbumModel = await ApiServices().getAlbums(userId.length.toString());
          if(userAlbumModel!=null){
            ConstantWidgets().showAlertDialog(context, 1);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(userDetailsModel.username,userDetailsModel.id.toString(),userAlbumModel),
              ), //MaterialPageRoute
            );
          }
          else{
            ConstantWidgets().showAlertDialog(context, 1);
            ConstantWidgets().showToast('Unable to Fetch Album. Please try again later');

          }

        }
        else{
          ConstantWidgets().showAlertDialog(context, 1);

          ConstantWidgets().showToast('Unable to Fetch Details. Please try again later');
        }

      }
      else{

        ConstantWidgets().showAlertDialog(context, 1);
        ConstantWidgets().showToast(Constants.password_error_text);
      }
    }
    else{
      ConstantWidgets().showAlertDialog(context, 1);

      ConstantWidgets().showToast(Constants.email_error_text);
    }


  }

  bool validateEmail(String email){
    return EmailValidator.validate(email);
  }

   bool validatePassword(String password, [int minLength = 8]) {
     if (password == null || password.isEmpty) {
       return false;
     }

     bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
     bool hasDigits = password.contains(new RegExp(r'[0-9]'));
     bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
     bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
     bool hasMinLength = password.length > minLength;

     return hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters & hasMinLength;
   }


}
