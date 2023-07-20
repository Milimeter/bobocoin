import 'package:binance_cl/screens/app/home/controller/changenow_controller.dart';
import 'package:binance_cl/screens/app/home/controller/home_controller.dart';
import 'package:get/get.dart' hide Trans;

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ChangeNowController());
  }
}
