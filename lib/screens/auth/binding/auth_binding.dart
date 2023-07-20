import 'package:binance_cl/screens/auth/controllers/auth_controller.dart';
import 'package:get/get.dart' hide Trans;

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
