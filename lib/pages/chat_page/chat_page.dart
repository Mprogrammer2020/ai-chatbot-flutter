import 'package:netset_ai/pages/chat_page/chat_controller.dart';
import 'package:netset_ai/pages/dashboard/category_model.dart';
import 'package:netset_ai/pages/dashboard/dashboard.dart';
import 'package:netset_ai/resources/colors/app_colors.dart';
import 'package:netset_ai/utils/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:netset_ai/utils/image_dialog.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../utils/show_up.dart';
import 'chat_model.dart';

class ChatPage extends StatefulWidget {
  final CharacterModel characterModel;

  ChatPage({required this.characterModel});

  @override
  State<StatefulWidget> createState() {
    return ChatPageState(characterModel: characterModel);
  }
}

class ChatPageState extends State<ChatPage> {
  final ScrollController _controllerScroll = ScrollController();
  TextEditingController messageController = TextEditingController();

  CharacterModel characterModel;
  late ChatController chatController;
  late stt.SpeechToText speech;
  FlutterTts flutterTts = FlutterTts();

  ChatPageState({required this.characterModel});

  var available = false;

  @override
  void initState() {
    super.initState();
    chatController = Get.put(ChatController());
    // chatController.setUpList();
    print("listSizeOnInit${chatController.chatList.value.length}");
    print("onInitCalled>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    initSpeech();
    initTTS();
  }

  Future initTTS() async {
    await flutterTts.setLanguage("hi-IN");

    await flutterTts.setSpeechRate(0.5);

    await flutterTts.setVolume(1.0);

    await flutterTts.setPitch(1.0);
    await flutterTts.setVoice({"name": "Karen", "locale": "hi-IN"});
  }

  Future _speak(String message) async {
    chatController.speakCompleted.value = false;
    var result = await flutterTts.speak(message);
    _speakCompletion();
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future _speakCompletion() async {
    flutterTts.setCompletionHandler(() {
      chatController.speakCompleted.value = true;
    });
  }

  Future _stopSpeaking() async {
    await flutterTts.stop();
  }

  initSpeech() async {
    speech = stt.SpeechToText();
    available = await speech.initialize(
      onStatus: (status) {
        print("speechHas $status.");
        if (status == "done") {
          chatController.listening.value = false;
          chatController.listening.refresh();
          if (chatController.finalSpeechToText.value ==
              "Speak now!\nI'm here to listen you...") {
            return;
          }
          print("sizeOfListBeforeAdd::${chatController.chatList.value.length}");
          sendMessageAndRefresh(
              chatController.finalSpeechToText.value, true, true);
          chatController.chatLoading.value = true;
          if (
              characterModel.characterDesc.contains("IMAGE")) {
            chatController
                .imageGenerationApi(
                    chatController.finalSpeechToText.value, "512x512", 5)
                .then((value) {
              sendMessageAndRefresh(value.data![0].url!, false, false);
            });
          } else {
            chatController
                .sendMessage(chatController.finalSpeechToText.value, "user")
                .then((value) {
              sendMessageAndRefresh(
                  value.choices![0].message!.content.toString(), false, true);
            });
          }
        }
      },
      onError: (errorNotification) {
        print("speechOnError $errorNotification.");
        stopSpeech(speech);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((value) => _scrollDown());
    return WillPopScope(
      onWillPop: () async {
        chatController.chatList.value.clear();
        stopSpeech(speech);
        _stopSpeaking();
        Get.to(() => DashBoard())
            ?.then((value) => Get.delete<ChatController>());
        return true;
      },
      child: SafeArea(
          child: Scaffold(
        backgroundColor: AppColors.black,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(80, 57, 129, 1.0),
                Color.fromRGBO(105, 187, 131, 1.0),
              ],
            ),
            color: AppColors.black,
          ),
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.black,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(CommonMethods.setPNGImage(
                                  characterModel.characterImage)))),
                    ),
                    Text(
                      characterModel.characterName,
                      style: TextStyle(
                          fontFamily: "medium",
                          fontSize: 16,
                          color: AppColors.white),
                    ),
                    Text(
                      characterModel.characterDesc,
                      style: TextStyle(
                          fontFamily: "PoppinsThin",
                          fontSize: 12,
                          color: AppColors.white),
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 70),
                          child: Obx(
                            () => ListView.builder(
                              controller: _controllerScroll,
                              itemCount: chatController.chatList.value.length,
                              itemBuilder: (context, index) {
                                return chatController
                                            .chatList[index].isSenderMe ==
                                        false
                                    ? ShowUp(
                                        child: recieverView(
                                            context,
                                            chatController.chatList[index],
                                            index,
                                            chatController),
                                        delay: 500,
                                      )
                                    : ShowUp(
                                        child: senderView(context,
                                            chatController.chatList[index]),
                                        delay: 500,
                                      );
                              },
                            ),
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    chatController.chatList.value.clear();
                    stopSpeech(speech);
                    _stopSpeaking();
                    Get.to(() => DashBoard())
                        ?.then((value) => Get.delete<ChatController>());
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: AppColors.white,
                  ),
                ),
              ),
              Obx(() => chatLoading()),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 20, bottom: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width - 60,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.darkGrey),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: TextFormField(
                                      controller: messageController,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: "regular",
                                          fontSize: 14),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.send,
                                      cursorColor: AppColors.white,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        hintText: "What's your query?",
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "regular",
                                            color: AppColors.black),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (messageController.text == "") {
                                        return;
                                      }
                                      chatController.chatLoading.value = true;
                                      sendMessageAndRefresh(
                                          messageController.text.trim(),
                                          true,
                                          false);
                                      if (characterModel.characterDesc
                                              .contains("IMAGE")) {
                                        chatController
                                            .imageGenerationApi(
                                                messageController.text.trim(),
                                                "512x512",
                                                5)
                                            .then((value) {
                                          for (var element in value.data!) {
                                            sendMessageAndRefresh(
                                                element.url as String,
                                                false,
                                                false);
                                          }
                                        });
                                      } else {
                                        chatController
                                            .sendMessage(
                                                messageController.text.trim(),
                                                "user")
                                            .then((value) {
                                          sendMessageAndRefresh(
                                              value.choices![0].message!.content
                                                  .toString(),
                                              false,
                                              true);
                                        });
                                      }

                                      messageController.text = "";
                                    },
                                    child: Image(
                                      image: AssetImage(
                                          CommonMethods.setPNGImage("send")),
                                      width: 30,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          chatController.listening.value = true;
                          chatController.listening.refresh();
                          stopSpeech(speech).then((value) => callSpeech());
                        },
                        child: Image(
                          image: AssetImage(CommonMethods.setPNGImage("voice")),
                          width: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Obx(
                () {
                  return chatController.listening.value == true
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: AppColors.darkGreyTransparent,
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Lottie.asset("assets/json/listening.json",
                                    width: 200),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    chatController.finalSpeechToText.value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 16,
                                        fontFamily: "bold"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container();
                },
              )
            ],
          ),
        ),
      )),
    );
  }

  Future callSpeech() async {
    chatController.finalSpeechToText.value =
        "Speak now!\nI'm here to listen you...";

    if (available) {
      speech.listen(
        onResult: (result) {
          print("speechOnResult ${result.recognizedWords}");
          chatController.finalSpeechToText.value = result.recognizedWords;
        },
      );
    }
  }

  Future stopSpeech(stt.SpeechToText speech) async {
    await speech.stop();
    await speech.cancel();
  }

  sendMessageAndRefresh(String message, bool isME, bool isMessageTypeText) {
    print(
        "send message called with list ${chatController.chatList.value.length}");
    chatController.chatList.value
        .add(ChatModelApp(isME, message, isMessageTypeText));
    chatController.chatList.refresh();
    print(
        "send message called with list after add ${chatController.chatList.value.length}");
    if (isME == false && isMessageTypeText == true) {
      _speak(message);
    } else {}

    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => _scrollDown());
  }

  void _scrollDown() {
    if (_controllerScroll.hasClients) {
      _controllerScroll.animateTo(
        _controllerScroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  Widget recieverView(BuildContext context, ChatModelApp chatModel, int index,
      ChatController chatController) {
    return Wrap(children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: chatController.isImageTypeResponse.value == false
            ? Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 + 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        color: AppColors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Wrap(children: [
                        Text(
                          chatModel.message,
                        ),
                      ]),
                    ),
                  ),
                  Obx(
                    () {
                      if (chatController.speakCompleted.value == false &&
                          index == chatController.chatList.value.length - 1) {
                        return GestureDetector(
                            onTap: () {
                              chatController.speakCompleted.value == false;
                              _stopSpeaking();
                            },
                            child: Lottie.asset("assets/json/speaker.json",
                                width: 150));
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              )
            : Container(
          width: 200,height: 200,
          decoration: BoxDecoration(color: AppColors.white,borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  Center(child: Lottie.asset("assets/json/image_loader.json",width: 100,height: 100)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GestureDetector(
                      onTap: () async{
                        await showDialog(context: context, builder:(context) => ImageDialog( url: chatModel.message));
                       ;
                      },
                      child: Image.network(
                        chatModel.message,
                        width:200,
                        height: 200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    ]);
  }

  Widget chatLoading() {
    if (chatController.chatLoading.value == true) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child:
              Lottie.asset("assets/json/typing.json", width: 100, height: 100),
        ),
      );
    } else {
      return Center();
    }
  }

  Widget senderView(BuildContext context, ChatModelApp chatModel) {
    return Wrap(children: [
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 2 + 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
                color: AppColors.appColor),
            child: Wrap(children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  chatModel.message,
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ]),
          ),
        ),
      ),
    ]);
  }
}
