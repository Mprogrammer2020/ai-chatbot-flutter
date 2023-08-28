import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../../utils/common_methods.dart';

class CreateAccount extends StatelessWidget {
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


                        ],
                      ),
                    ),
                  )),
            ),
          ]),
        ));
  }

}
