import 'package:binance_cl/screens/app/markets/controller/markets_controller.dart';
import 'package:get/get.dart' hide Trans;

class MarketsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MarketsController());
  }
}
