// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:binance_cl/models/binance/changenow/available_currencies.dart';
import 'package:binance_cl/routes/app_pages.dart';
import 'package:binance_cl/services/api_calls.dart';
import 'package:binance_cl/shared/custom_toast.dart';
import 'package:binance_cl/utils/utilities.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";

class ChangeNowController extends GetxController {
  RxList<ChangeNowAvailableCurrencies> changeNowAvailableCurrencies =
      RxList<ChangeNowAvailableCurrencies>();
  Rx<ChangeNowAvailableCurrencies> fromAssetCurrency =
      ChangeNowAvailableCurrencies().obs;
  Rx<ChangeNowAvailableCurrencies> toAssetCurrency =
      ChangeNowAvailableCurrencies().obs;

  TextEditingController fromAmountController = TextEditingController();
  RxString error = RxString('');
  RxString fromAsset = RxString('');
  RxString toAsset = RxString('');
  RxDouble minAmount = RxDouble(0.001);
  RxString fromAmount = RxString("");
  RxString toAmount = RxString("0.0000000");
  RxBool reloading = RxBool(false);

  getExchangeCurrenciesList() async {
    try {
      List req = await APICalls().getCurrenciesList();  
      //log(req.toString());
      if (req.isNotEmpty) {
        changeNowAvailableCurrencies.value =
            (req).map((e) => ChangeNowAvailableCurrencies.fromJson(e)).toList();
      } else {
        cToast(title: "Notice!", message: "Unable to get exchange currencies");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  getMinimumExchangeAmount(context) async {
    try {
      buildShowDialog(context);
      String pair = "${fromAsset.value}_${toAsset.value}";
      Map req = await APICalls().getMinimumExchangeAmount(pair);

      if (req.isNotEmpty) {
        if (req.containsKey("error")) {
          Navigator.pop(context);
          error.value = req['error'];
          cToast(title: "Notice!", message: error.value);
        } else {
          fromAssetCurrency.value = changeNowAvailableCurrencies.value
              .firstWhere((element) => element.ticker! == fromAsset.value);
          toAssetCurrency.value = changeNowAvailableCurrencies.value
              .firstWhere((element) => element.ticker! == toAsset.value);
          minAmount.value = req['minAmount'];
          Navigator.pop(context);
          log(minAmount.value.toString());
          Get.toNamed(Routes.CRYPTO_TO_CRYPTO_CONVERTER);
        }
      } else {
        cToast(title: "Notice!", message: "Unable to get Swap Configuration.");
        Navigator.pop(context);
      }
    } catch (e) {
      log(e.toString());
      Get.back();
    }
  }

  getEstimatedExchangeAmount() async {
    try {
      reloading.value = true;
      String pair = "${fromAsset.value}_${toAsset.value}";
      Map req = await APICalls().getEstimatedExchangeAmount(pair,
          fromAmount.value.isNotEmpty ? fromAmount.value : minAmount.value);

      if (req.isNotEmpty) {
        if (req.containsKey("error")) {
          error.value = req['error'];
          cToast(title: "Notice!", message: error.value);
          reloading.value = false;
        } else {
          toAmount.value = req['estimatedAmount'].toString();
          reloading.value = false;
        }
      } else {
        cToast(
            title: "Notice!",
            message: "Unable to get estimated crypto equivalent.");
        reloading.value = false;
      }
    } catch (e) {
      log(e.toString());
      reloading.value = false;
    }
  }

  @override
  void onReady() {
    getExchangeCurrenciesList();
    super.onReady();
  }
}
