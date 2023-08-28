import 'package:get/get.dart';

class DashBoardController extends GetxController {
  RxBool isCarousel = true.obs;

  setCarousal(bool bool) {
    isCarousel.value = bool;
  }
}
