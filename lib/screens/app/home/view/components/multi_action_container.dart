import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/routes/app_pages.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:binance_cl/utils/utilities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart' hide Trans;

class MultiActionContainer extends StatefulWidget {
  final void Function(int) changePage;
  const MultiActionContainer({Key? key, required this.changePage})
      : super(key: key);

  @override
  State<MultiActionContainer> createState() => _MultiActionContainerState();
}

class _MultiActionContainerState extends State<MultiActionContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: heightSize(150),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: kContainerColor,
          borderRadius: BorderRadius.circular(Values().buttonRadius),
          border: Border.all(color: kGreyColor.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                item(
                  icon: Feather.briefcase,
                  text: "sav".tr(),
                  callback: () {
                    showHelpSnackBar(
                        context: context,
                        title: "Oh Snap!",
                        messages: "Content not available at the moment.");
                  },
                ),
                item(
                  icon: Feather.user_plus,
                  text: "ref".tr(),
                  callback: () {
                    Get.toNamed(Routes.REFERRALS);
                  },
                ),
                item(
                  icon: FontAwesome.line_chart,
                  text: "strtd".tr(),
                  callback: () {
                    showHelpSnackBar(
                        context: context,
                        title: "Oh Snap!",
                        messages: "Content not available at the moment.");
                  },
                ),
                item(
                  icon: Feather.percent,
                  text: "spt".tr(),
                  callback: () {
                    widget.changePage(2);
                  },
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                item(
                  icon: FontAwesome.fighter_jet,
                  text: "lpads".tr(),
                  callback: () {
                    Get.toNamed(Routes.LAUNCHPADS);
                  },
                ),
                item(
                  icon: FontAwesome.bank,
                  text: "depts".tr(),
                  callback: () {
                    Get.toNamed(Routes.DEPOSIT_SELECTOR);
                  },
                ),
                item(
                  icon: Entypo.book,
                  text: "bbcdy".tr(),
                  callback: () {
                    showHelpSnackBar(
                        context: context,
                        title: "Oh Snap!",
                        messages: "Content not available at the moment.");
                  },
                ),
                item(
                  icon: Feather.align_justify,
                  text: "mre".tr(),
                  callback: () {
                    showHelpSnackBar(
                        context: context,
                        title: "Oh Snap!",
                        messages: "Content not available at the moment.");
                  },
                ),
              ],
            )
          ],
        ));
  }

  Widget item(
      {required String text,
      required IconData icon,
      required VoidCallback callback}) {
    return GestureDetector(
      onTap: callback,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: kPrimaryColor.withOpacity(0.8),
          ),
          SizedBox(height: heightSize(8)),
          CText(
            text: text,
            size: 14,
            color: kText2Color,
          ),
        ],
      ),
    );
  }
}
