import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:netset_ai/resources/colors/app_colors.dart';
import 'package:netset_ai/utils/common_methods.dart';

class ImageDialog extends StatefulWidget {
  String url;

  ImageDialog({required this.url});

  @override
  State<StatefulWidget> createState() {
    return ImageDialogState(url: url);
  }
}

class ImageDialogState extends State<ImageDialog> {
  String url;

  ImageDialogState({required this.url});

  var downloaded = false;
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 500,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(url), fit: BoxFit.fitWidth)),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      saveImage(url);
                    },
                    child: downloaded == false
                        ? Icon(Icons.download_for_offline,
                            color: AppColors.black, size: 50)
                        : Lottie.asset(
                            "assets/json/downloading.json",
                            width: 100,
                            height: 100,
                            repeat: false,
                          ))),
            loading == true
                ? Center(child: Lottie.asset("assets/json/image_loader.json"))
                : Center()
          ],
        ),
      ),
    );
  }

  saveImage(String url) async {
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    var result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: "${widget} ${DateTime.timestamp()}");

    if (result.toString().contains("isSuccess: true")) {
      setState(() {
        downloaded = true;
        loading = false;
        Future.delayed(const Duration(seconds: 4),() {
          setState(() {
            downloaded = false;
          });
        },);
        try {
          CommonMethods.showSnackBar(context, "Image saved to gallery", AppColors.appColor, AppColors.white);
        } on Exception catch (e, s) {
          print(s);
        }
      });
    } else {
      setState(() {
        downloaded = false;
        loading = false;
      });
    }
  }
}
