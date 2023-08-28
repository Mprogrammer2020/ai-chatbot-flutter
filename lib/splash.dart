import 'dart:async';
import 'dart:ui';
import 'package:netset_ai/pages/dashboard/dashboard.dart';
import 'package:netset_ai/resources/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:netset_ai/utils/common_methods.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500),() {
      dotenv.load(fileName: "lib/.env" );
    },);
    Timer(
        const Duration(milliseconds: 4000),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashBoard())));
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: AppColors.black,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration: BoxDecoration(
               /*     gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(80, 57, 129, 1.0),
                        Color.fromRGBO(105, 187, 131, 1.0),
                      ],
                    ),*/
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
            // child:Lottie.asset("assets/json/chat_lottie.json")
            child:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(CommonMethods.setPNGImage("netsetai")),
            )
         )
      ],
    ));
  }
}
