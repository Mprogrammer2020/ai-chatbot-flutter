
import 'package:netset_ai/network/app_repository.dart';
import 'package:netset_ai/pages/chat_page/ChatResponse.dart';
import 'package:get/get.dart';

import 'chat_image_response.dart';

class ChatController extends GetxController{
  RxList chatList = [].obs;
  RxBool listening= false.obs;
  RxBool chatLoading= false.obs;
  RxBool speakCompleted= true.obs;
  RxBool isImageTypeResponse= false.obs;
  RxString finalSpeechToText="Speak now!\nI'm here to listen you...".obs;


  Future<ChatResponse> sendMessage(String message,String role) async {
    final response = await AppRepository().sendMessageApi(message, role);
    chatLoading.value=false;
    isImageTypeResponse.value=false;
    return response;
  }
  Future<ChatImageResponse> imageGenerationApi(String message,String size,int noOfImage) async {
    final response = await AppRepository().imageGenerationApi(message, size,noOfImage);

    chatLoading.value=false;
    isImageTypeResponse.value=true;

    return response;
  }


  @override
  void dispose() {
    chatList.clear();
    print("onDisposeCalled>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    super.dispose();
  }
}