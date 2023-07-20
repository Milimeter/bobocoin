// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:binance_cl/screens/app/home/controller/home_controller.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:loading_animation_widget/loading_animation_widget.dart'
    hide Trans;
import 'dart:math' as mth;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

modalSetup(context,
    {required double modalPercentageHeight,
    required Widget createPage,
    required bool showBarrierColor}) {
  HomeController homeController = Get.find<HomeController>();
  return showBarModalBottomSheet(
    duration: const Duration(milliseconds: 100),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
    ),
    context: context,
    barrierColor: showBarrierColor == true 
        ? Colors.black.withOpacity(.6)
        : Colors.transparent,
    builder: (context) => Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: homeController.keyBoardActive.value
            ? MediaQuery.of(context).size.height * modalPercentageHeight +
                MediaQuery.of(context).viewInsets.bottom
            : MediaQuery.of(context).size.height * modalPercentageHeight,
        child: createPage,
      ),
    ),
  );
}



String formatMoney(amount) {
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  // ignore: prefer_function_declarations_over_variables
  String Function(Match) mathFunc = (Match match) => '${match[1]},';
  String result = amount.toString().replaceAllMapped(reg, mathFunc);
  return result;
}

String numberFormat(double n) {
  String num = n.toString();
  int len = num.length;

  if (n >= 1000 && n < 1000000) {
    return '${num.substring(0, len - 3)}.${num.substring(len - 3, 1 + (len - 3))}K';
  } else if (n >= 1000000 && n < 1000000000) {
    return '${num.substring(0, len - 6)}.${num.substring(len - 6, 1 + (len - 6))}M';
  } else if (n > 1000000000) {
    return '${num.substring(0, len - 9)}.${num.substring(len - 9, 1 + (len - 9))}B';
  } else {
    return num.toString();
  }
}

showSuccessSnackBar(
    {required context, required String title, required String messages}) {
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: messages,
      contentType: ContentType.success,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showErrorSnackBar(
    {required context, required String title, required String messages}) {
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: messages,
      contentType: ContentType.failure,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showWarningSnackBar(
    {required context, required String title, required String messages}) {
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: messages,
      contentType: ContentType.success,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showHelpSnackBar(
    {required context, required String title, required String messages}) {
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: messages,
      contentType: ContentType.success,
      color: kPrimaryColor,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

buildShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: kTransparent,
      builder: (BuildContext context) {
        return Container(
          height: heightSize(150),
          width: widthSize(200),
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.2),
          ),
          child: Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: kPrimaryColor,
              secondRingColor: kPrimaryColor,
              size: 60,
            ),
          ),
        );
      });
}


String truncate(String text, {required int length}) {
  String omission = '...';
  if (length >= text.length) {
    return text;
  }
  return text.replaceRange(length, text.length, omission);
}
