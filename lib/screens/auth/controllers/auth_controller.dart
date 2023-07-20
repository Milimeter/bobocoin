import 'dart:async';
import 'dart:developer';

import 'package:binance_cl/constants/steps.dart';
import 'package:binance_cl/constants/strings.dart';
import 'package:binance_cl/routes/app_pages.dart';
import 'package:binance_cl/services/api_calls.dart';
import 'package:binance_cl/services/storage.dart';
import 'package:binance_cl/shared/custom_toast.dart';
import 'package:binance_cl/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class AuthController extends GetxController {
  TextEditingController phoneNumberSigninController = TextEditingController();
  TextEditingController emailSigninController = TextEditingController();
  TextEditingController passwordSigninController = TextEditingController();

  TextEditingController emailSignupController = TextEditingController();
  TextEditingController phoneNumberSignupController = TextEditingController();
  TextEditingController fullnameSignupController = TextEditingController();
  TextEditingController passwordSignupController = TextEditingController();
  TextEditingController repeatPasswordSignupController =
      TextEditingController();

  RxString phoneNumberSignin = RxString("");
  RxString emailSignin = RxString("");
  RxString passwordSignin = RxString("");

  RxString emailSignup = RxString("");
  RxString phoneNumberSignup = RxString("");
  RxString fullnameSignup = RxString("");
  RxString passwordSignup = RxString("");
  RxString repeatPasswordSignup = RxString("");
  RxString countryCode = RxString("+86");
  RxString country = RxString("中国");

  RxString error = RxString("");

  RxBool emailInput = RxBool(false);
  RxBool phoneInput = RxBool(true);

  changeToPhone() {
    phoneInput.value = true;
    emailInput.value = false;
  }

  changeToEmail() {
    emailInput.value = true;
    phoneInput.value = false;
  }

  navigate() async {
    String step = await Storage.getStep() ?? '';
    log("Step is $step");
    switch (step) {
      case Steps.AUTH:
        Timer(const Duration(seconds: 4), () {
          Get.toNamed(Routes.SIGNIN_SCREEN);
        });
        break;
      case Steps.DONE:
        Timer(const Duration(seconds: 4), () {
          Get.toNamed(Routes.MAIN_APP);
        });
        break;
      default:
        Timer(const Duration(seconds: 4), () {
          Get.toNamed(Routes.SIGNIN_SCREEN);
        });
    }
  }

  checkEmailExists(context) async {
    try {
      log("Checking if email exist....");
      buildShowDialog(context);
      Map req = await APICalls().checkEmailExists(emailSignup.value.trim());
      log(req.toString());
      if (req.isNotEmpty) {
        if (req['status'] != 200) {
          Get.back();
          error.value = req['error'];
          cToast(title: "Notice!", message: error.value);
        } else {
          if (req['message'] == "Email Not found") {
            createMnemonics();
//navigate
          } else {
            Get.back();
            cToast(
                title: "Notice!",
                message: "Email address belongs to another user");
          }
        }
      } else {
        Get.back();
        cToast(title: "Notice!", message: "Please try again later.");
      }
    } catch (e) {
      Get.back();
      log(e.toString());
    }
  }

  checkPhoneExists(context) async {
    try {
      log("Checking if phone exist....");
      buildShowDialog(context);
      Map req =
          await APICalls().checkPhoneExists(phoneNumberSignup.value.trim());
      log(req.toString());
      if (req.isNotEmpty) {
        if (req['status'] != 200) {
          Get.back();
          error.value = req['error'];
          cToast(title: "Notice!", message: error.value);
        } else {
          if (req['message'] == "Phone Not found") {
            createMnemonics();
//navigate
          } else {
            Get.back();
            cToast(
                title: "Notice!",
                message: "Phone number belongs to another user");
          }
        }
      } else {
        Get.back();
        cToast(title: "Notice!", message: "Please try again later.");
      }
    } catch (e) {
      Get.back();
      log(e.toString());
    }
  }

  createMnemonics() async {
    try {
      log("Creating Mnemonics...");
      HDWallet newWalletInstance = HDWallet();
      String mnemonics = newWalletInstance.mnemonic();
      await Storage.saveData(WALLET_MNEMONICS, mnemonics);
      log(mnemonics);

      String walletAddress =
          newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeBitcoin);
      log(walletAddress);
      log('----- Bitcoin address: $walletAddress');
      if (walletAddress.isNotEmpty) {
//save phrases route
        createAccount();
      } else {
        Get.back();
        cToast(title: "Notice", message: "Unable to generate wallet");
      }
    } catch (e) {
      Get.back();
      log(e.toString());
    }
  }

  createAccount() async {
    try {
      log("Creating account...");
      String mnemonics = await Storage.readData(WALLET_MNEMONICS);

      Map data = {
        "fullname": fullnameSignup.value.trim(),
        "email": emailSignup.value.trim(),
        "phone": phoneNumberSignup.value.trim(),
        "password": passwordSignup.value.trim(),
        "mnemonics": mnemonics,
        "country": country.value.trim(),
        "countrycode": countryCode.value.trim(),
      };
      log(data.toString());
      Map req = await APICalls().createAccount(data);
      log(req.toString());
      if (req.isNotEmpty) {
        if (req['status'] != 200) {
          Get.back();
          error.value = req['message'];
          cToast(title: "Notice!", message: error.value);
        } else {
          log(req['token']);
          if (phoneInput.value == true) {
            emailSignup.value = "";
          } else {
            phoneNumberSignup.value = "";
          }
          await Storage.saveData("email", emailSignup.value.trim());
          await Storage.saveData("phone", phoneNumberSignup.value.trim());
          await Storage.saveData("token", req['token']);
          log("Signup Complete :)");
          await Storage.setStep(Steps.DONE);
          Get.toNamed(Routes.MAIN_APP);
//navigate home
        }
      } else {
        Get.back();
        cToast(title: "Notice!", message: "Please try again later.");
      }
    } catch (e) {
      Get.back();
      log(e.toString());
    }
  }

  loginEmailToAccount(context) async {
    try {
      buildShowDialog(context);
      Map data = {
        "email": emailSignin.value.trim(),
        "password": passwordSignin.value.trim(),
      };
      log(data.toString());
      Map req = await APICalls().loginWithEmail(data);
      log(req.toString());
      if (req.isNotEmpty) {
        if (req['status'] != 200) {
          Get.back();
          error.value = req['message'];
          cToast(title: "Notice!", message: error.value);
        } else {
          log(req['token']);
          log(req['mnemonics']);
          await Storage.saveData("email", emailSignin.value.trim());
          await Storage.saveData("token", req['token']);
          signInToWalletAccount(req['mnemonics']);
//navigate home
        }
      } else {
        Get.back();
        cToast(title: "Notice!", message: "Please try again later.");
      }
    } catch (e) {
      Get.back();
      log(e.toString());
    }
  }

  loginPhoneToAccount(context) async {
    try {
      buildShowDialog(context);
      Map data = {
        "phone": phoneNumberSignin.value.trim(),
        "password": passwordSignin.value.trim(),
      };
      log(data.toString());
      Map req = await APICalls().loginWithPhone(data);
      log(req.toString());
      if (req.isNotEmpty) {
        if (req['status'] != 200) {
          Get.back();
          error.value = req['message'];
          cToast(title: "Notice!", message: error.value);
        } else {
          log(req['token']);
          log(req['mnemonics']);
          await Storage.saveData("phone", phoneNumberSignin.value.trim());
          await Storage.saveData("token", req['token']);
          signInToWalletAccount(req['mnemonics']);
//navigate home
        }
      } else {
        Get.back();
        cToast(title: "Notice!", message: "Please try again later.");
      }
    } catch (e) {
      Get.back();
      log(e.toString());
    }
  }

  signInToWalletAccount(mnemonics) async {
    try {
      log("SAVING MNEMONICS...");
      HDWallet newWalletInstance = HDWallet.createWithMnemonic(mnemonics);
      await Storage.saveData(WALLET_MNEMONICS, newWalletInstance.mnemonic());
      log('Your BItcoin wallet address is ${newWalletInstance.getAddressForCoin(TWCoinType.TWCoinTypeBitcoin)}');

      await Storage.setStep(Steps.DONE);
      Get.toNamed(Routes.MAIN_APP);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onReady() {
    navigate();
    super.onReady();
  }
}
