
import 'package:dio/dio.dart';

import 'dio_client.dart';
import 'endpoints.dart';

class AppApi {


  Future<Response> sendChat(String message, String role) async {
    try {
     var response = (await DioClient().post(
        Endpoints.chatCompletion,
        data: {
          "model":"gpt-3.5-turbo",
          "messages": [
            {"content": message, "role": role}
          ]
        },
      ));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> imageGenerationApi(String prompt, String size,int noOfImage) async {
    try {
     var response = (await DioClient().post(
        Endpoints.imageGeneration,
        data: {
          "prompt":prompt,
          "n": noOfImage,
          "size":size
        },
      ));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
