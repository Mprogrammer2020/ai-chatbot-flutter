import 'dart:ui';

import 'package:netset_ai/pages/dashboard/dashboard.dart';
import 'package:netset_ai/resources/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/common_methods.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        Align(
          child: ClipRRect(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(80, 57, 129, 0.8),
                      Color.fromRGBO(105, 187, 131, 0.8),
                    ],
                  ),
                  color: AppColors.black),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Image.asset(
                        CommonMethods.setPNGImage("netsetai"),
                        width: 300,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontFamily: "bold",
                              fontSize: 24,
                              color: AppColors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                      child: TextFormField(
                        style: TextStyle(
                            fontFamily: "medium",
                            fontSize: 16,
                            color: AppColors.white),
                        decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: AppColors.darkGrey,
                                fontSize: 16,
                                fontFamily: "medium"),
                            prefixIcon:
                                Icon(Icons.email, color: AppColors.darkGrey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.black),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        obscureText: true,
                        style: TextStyle(
                            fontFamily: "medium",
                            fontSize: 16,
                            color: AppColors.white),
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: AppColors.darkGrey,
                                fontSize: 16,
                                fontFamily: "medium"),
                            prefixIcon:
                                Icon(Icons.password, color: AppColors.darkGrey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColors.black),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)))),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(DashBoard());
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.appColor,
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontFamily: "medium",
                                    fontSize: 16,
                                    color: AppColors.white),
                              ),
                            )),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Don't have account? Signup",
                          style: TextStyle(
                              fontFamily: "medium",
                              fontSize: 16,
                              color: AppColors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
        ),
      ]),
    ));
  }
}
