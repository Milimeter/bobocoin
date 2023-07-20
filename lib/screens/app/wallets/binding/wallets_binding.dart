import 'package:binance_cl/screens/app/wallets/controller/balance_controller.dart';
import 'package:binance_cl/screens/app/wallets/controller/wallets_controller.dart';
import 'package:get/get.dart' hide Trans;

class WalletsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WalletsController());
    Get.put(BalanceController());
  }
}
