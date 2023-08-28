import 'dart:ui';

import 'package:netset_ai/resources/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/common_methods.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CupertinoPageScaffold(
          child:Stack(children: [
        Align(
            alignment: Alignment.center,
            child: Image(
                image: AssetImage(CommonMethods.setPNGImage("chat_bot")))),
        SingleChildScrollView(
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
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(CommonMethods.setPNGImage("ai")),
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () => actionSheet(context),
                    child: Text(
                      "Profile Name:",
                      style: TextStyle(
                          fontFamily: "bold",
                          fontSize: 16,
                          color: AppColors.white),
                    ),
                  ),
                  Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "medium",
                        color: AppColors.white),
                  ),
                  ClipRRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          color: AppColors.appColor,
                        )),
                  )
                ],
              ),
            ),
          )),
        ),
      ]),
    ));
  }
  void actionSheet(BuildContext context){
    showCupertinoModalPopup(context: context, builder: (context) =>  CupertinoActionSheet(actions: [
      CupertinoActionSheetAction(onPressed: () {
        Navigator.pop(context);
      }, child: Text("login")),
      CupertinoActionSheetAction(onPressed: () {
        Navigator.pop(context);
      }, child: Text("logout")),
      CupertinoActionSheetAction(onPressed: () {
        Navigator.pop(context);
      }, child: Text("cancel"))
    ],),);

}
}
