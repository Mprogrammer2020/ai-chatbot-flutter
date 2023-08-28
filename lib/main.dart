import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:netset_ai/splash.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AI ChatBot',
      theme: ThemeData.light().copyWith(
          primaryColor: Colors.black26, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black)
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
