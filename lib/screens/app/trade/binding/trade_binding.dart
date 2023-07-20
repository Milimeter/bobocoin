import 'package:binance_cl/screens/app/trade/controller/trade_controller.dart';
import 'package:get/get.dart' hide Trans;

class TradeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TradeController());
  }
}
