import 'dart:io';
import 'dart:ui';

import 'package:netset_ai/pages/chat_page/chat_page.dart';
import 'package:netset_ai/pages/dashboard/category_model.dart';
import 'package:netset_ai/pages/dashboard/dashboard_controller.dart';
import 'package:netset_ai/pages/profile/profile_page.dart';
import 'package:netset_ai/resources/colors/app_colors.dart';
import 'package:netset_ai/utils/common_methods.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class DashBoard extends StatelessWidget {
  List<CharacterModel> characterList = [];
  final dashboardController = DashBoardController();

  DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    setUpCharacterList();
    print(dotenv.env['CHAT_GPT_API_KEY']);
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: SafeArea(
          child: Scaffold(
              drawer: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: MediaQuery.of(context).size.height,
                  color: AppColors.grey,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Expanded(
                        child: DrawerHeader(
                          decoration: BoxDecoration(
                            color: AppColors.black,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                CommonMethods.setPNGImage("chat_bot"),
                                width: 70,
                              ),
                              Text('NetsetAI',
                                  style: TextStyle(color: AppColors.white)),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Profile',
                          style: TextStyle(
                              color: Colors.white, fontFamily: "medium"),
                        ),
                        leading: Icon(
                          Icons.person_pin,
                          color: AppColors.white,
                        ),
                        tileColor: AppColors.appColor,
                        selectedTileColor: AppColors.appColor,
                        onTap: () {
                          Navigator.pop(context);
                          Get.to(()=>ProfilePage());
                        },
                      ),
                      ListTile(
                        title: const Text('Notifications',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "medium")),
                        leading: Icon(
                          Icons.notifications_active,
                          color: AppColors.white,
                        ),
                        onTap: () {
                          CommonMethods.showSnackBar(
                              context,
                              "Notifications clicked",
                              AppColors.appColor,
                              AppColors.white);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text('Settings',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "medium")),
                        leading: Icon(
                          Icons.settings,
                          color: AppColors.white,
                        ),
                        onTap: () {
                          Navigator.pop(context);


                        },
                      ),
                    ],
                  )),
              appBar: AppBar(
                title: Text(
                  "NetsetAI",
                  style: TextStyle(
                      fontFamily: "bold", color: AppColors.white),
                ),
                centerTitle: true,
                backgroundColor: AppColors.black,
                actions: <Widget>[
                  IconButton(
                    icon: Obx(
                      () {
                        return Icon(
                          dashboardController.isCarousel == true
                              ? Icons.grid_view
                              : Icons.view_carousel,
                          color: Colors.white,
                        );
                      },
                    ),
                    onPressed: () {
                      if (dashboardController.isCarousel.value) {
                        dashboardController.setCarousal(false);
                      } else {
                        dashboardController.setCarousal(true);
                      }
                    },
                  )
                ],
              ),
              body: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: AppColors.black,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        "Choose the character to \nchat for the support ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "medium",
                                        color: AppColors.white)),
                                WidgetSpan(
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 25,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(() {
                          return dashboardController.isCarousel == false
                              ? gridView()
                              : carouseView();
                        })
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }

  Widget gridView() {
    return Center(
      child: GridView.builder(
        primary: true,
        shrinkWrap: true,
        itemCount: characterList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Get.to(()=>ChatPage( characterModel: characterList[index],));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(80, 57, 129, 1.0),
                          Color.fromRGBO(105, 187, 131, 1.0),
                        ],
                      ),
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              characterList[index].characterName,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "bold",
                                  color: AppColors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage(CommonMethods.setPNGImage(
                                  characterList[index].characterImage)),
                              width: 70,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              characterList[index].characterDesc,
                              style: TextStyle(
                                  fontSize: 8,
                                  fontFamily: "medium",
                                  color: AppColors.white),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget carouseView() {
    return SingleChildScrollView(
      child: CarouselSlider(
        options: CarouselOptions(height: 450.0),
        items: characterList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(ChatPage(characterModel: i));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromRGBO(80, 57, 129, 1.0),
                            Color.fromRGBO(105, 187, 131, 1.0),
                          ],
                        ),
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                i.characterName,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: "bold",
                                    color: AppColors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                image: AssetImage(
                                    CommonMethods.setPNGImage(i.characterImage)),
                                height: 250,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  i.characterDesc,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "medium",
                                      color: AppColors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  setUpCharacterList() {
    characterList.clear();
    characterList.add(
        CharacterModel("Rubyn", "ai", "Choose me for TEXT based response"));
    characterList
        .add(CharacterModel("Hexrix", "it_expert", "I'm here for IMAGE based response"));

  }
}
