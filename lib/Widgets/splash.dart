import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rejolut_assessment/Utils/colors.dart';
import 'package:rejolut_assessment/Widgets/login_view.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SplashScreen(
      seconds: 5,
      navigateAfterSeconds:Login(),
      photoSize: 200,
      image: Image.asset("assets/logo.png"),
      backgroundColor:MyColors.darkBlue,
      loaderColor: MyColors.buttonColor,
    );
  }
  
}
