import 'dart:developer';

import 'package:binance_cl/constants/assets_path.dart';
import 'package:binance_cl/routes/app_pages.dart';
import 'package:binance_cl/shared/custom_toast.dart';
import 'package:binance_cl/shared/search_container.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;

class TopAction extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;
  const TopAction({Key? key, required this.drawerKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightSize(45),
      width: double.infinity,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              drawerKey.currentState!.openDrawer();
            },
            child: Container(
              height: heightSize(45),
              width: widthSize(45),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kGreyColor),
              ),
              child: Center(
                child:
                    SvgPicture.asset(profile, color: kPrimaryColor, height: 35),
              ),
            ),
          ),
          SizedBox(width: widthSize(10)),
          Expanded(
            child: SearchContainer(
              width: double.infinity,
              height: heightSize(45),
              text: "schinfo".tr(),
              callback: () {},
            ),
          ),
          SizedBox(width: widthSize(10)),
          GestureDetector(
            onTap: () async {
              String result = await Get.toNamed(Routes.QR_SCANNER);
              log("result1 is $result");
              if (result.isNotEmpty) {
                log("result is $result");
                cToast(title: "Notice", message: "Not Available");
              }
            },
            child: SvgPicture.asset(
              scan,
              color: kGreyColor,
              height: 35,
            ),
          ),
          SizedBox(width: widthSize(10)),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.APP_NOTIFICATION);
            },
            child: SvgPicture.asset(
              bell,
              color: kGreyColor,
              height: 35,
            ),
          ),
        ],
      ),
    );
  }
}
