class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://api.openai.com/v1";
  static const String contentType = "application/json";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 15000);

  static const String chatCompletion = '/chat/completions';
  static const String imageGeneration = '/images/generations';
}