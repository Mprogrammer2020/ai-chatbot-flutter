import 'package:flutter/material.dart';

class CommonMethods {

  static showSnackBar(BuildContext context, String message,
      Color backgroundColor, Color textColor) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  static showLoading(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 15), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  static showLoadingWithMessageImage(BuildContext context,String message,String image) {
    AlertDialog alert = AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Image.asset(image,width: 50,height: 50,),
          Container(
              margin: EdgeInsets.only(left: 15), child: Text(message,style: TextStyle(color: Colors.purple),)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
   static setPNGImage(String imageName){
    return "assets/images/$imageName.png";
  }
   static setGIFImage(String imageName){
    return "assets/images/$imageName.gif";
  }
   static setJPGImage(String imageName){
    return "assets/images/$imageName.jpg";
  }

}
