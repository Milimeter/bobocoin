import 'package:binance_cl/constants/assets_path.dart';
import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/routes/app_pages.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/shared/custom_toast.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart' hide Trans;

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width * 0.70,
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Values().buttonRadius),
            bottomRight: Radius.circular(Values().buttonRadius),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.08),
            Align(
              child: CircleAvatar(
                backgroundColor: kContainerColor,
                radius: 60,
                child: Image.asset(logo, width: widthSize(70)),
              ),
            ),
            SizedBox(height: heightSize(10)),
             CText(
              text: "welbob".tr(),
              size: 18,
              height: 1.2,
            ),
             CText(
              text: "jnexch".tr(),
              size: 14,
              color: kText2Color,
            ),
            SizedBox(height: heightSize(30)),
            guide(),
            SizedBox(height: heightSize(30)),
            item(
              text: "setns".tr(),
              icon: Entypo.sound_mix,
              callback: () {
                Get.toNamed(Routes.SETTINGS);
              },
            ),
            item(
              text: "lng".tr(),
              icon: Octicons.globe,
              callback: () {
                Get.toNamed(Routes.LANGUAGE);
              },
            ),
            item(
              text: "hns".tr(),
              icon: Feather.alert_circle,
              callback: () {
                Get.toNamed(Routes.HELP_AND_SUPPORT);
              },
            ),
            item(
              text: "shboap".tr(),
              icon: Feather.external_link,
              callback: () {
                cToast(title: "Notice", message: "Coming Soon");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget guide() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               CText(
                text: "begigude".tr(),
                size: 14,
                color: kTextColor,
              ),
              SizedBox(height: heightSize(5)),
               CText(
                text: "legstd".tr(),
                size: 14,
                color: kText2Color,
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Feather.book,
            color: kPrimaryColor,
            size: 35,
          )
        ],
      ),
    );
  }

  Widget item(
      {required String text,
      required IconData icon,
      required VoidCallback callback}) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.only(bottom: 40),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            Icon(
              icon,
              color: kText2Color,
              size: 25,
            ),
            SizedBox(width: widthSize(20)),
            CText(
              text: text,
              size: 18,
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: kText2Color,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
