import 'package:netset_ai/network/app_api.dart';
import 'package:netset_ai/pages/chat_page/ChatResponse.dart';
import 'package:dio/dio.dart';

import '../pages/chat_page/chat_image_response.dart';
import 'dio_exceptions.dart';

class AppRepository {

  Future<ChatResponse> sendMessageApi(String message, String role) async {
    try {
      final response = await AppApi().sendChat(message, role);
      return ChatResponse.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
  Future<ChatImageResponse> imageGenerationApi(String message,String size,int noOfImage) async {
    try {
      final response = await AppApi().imageGenerationApi(message, size,noOfImage);
      return ChatImageResponse.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

}
