import 'dart:developer';

import 'package:binance_cl/models/user_data.dart';
import 'package:binance_cl/services/api_calls.dart';
import 'package:binance_cl/services/storage.dart';
import 'package:get/get.dart' hide Trans;

import '../../../../shared/custom_toast.dart';

class WalletsController extends GetxController {
  RxBool switchAccountTransferred = RxBool(false);
  Rx<UserData> userData = UserData().obs;
  RxString error = "".obs;
  getProfile() async {
    try {
      String email = await Storage.readData("email") ?? "";
      String phone = await Storage.readData("phone") ?? "";
      if (phone.isNotEmpty) {
        Map req = await APICalls().getUserProfile(phone);
        if (req.isNotEmpty) {
          if (req['status'] != 200) {
            error.value = req['message'];
            cToast(title: "Notice!", message: error.value);
          } else {
            userData.value = UserData.fromJson(req['data']);
            log(userData.value.email!);
          }
        } else {
          cToast(title: "Notice!", message: "Unable to get user Profile.");
        }
      } else {
        Map req = await APICalls().getUserProfile(email);
        if (req.isNotEmpty) {
          if (req['status'] != 200) {
            error.value = req['message'];
            cToast(title: "Notice!", message: error.value);
          } else {
            userData.value = UserData.fromJson(req['data']);
            log(userData.value.email!);
          }
        } else {
          cToast(title: "Notice!", message: "Unable to get user Profile.");
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onReady() {
    getProfile();
    super.onReady();
  }
}
