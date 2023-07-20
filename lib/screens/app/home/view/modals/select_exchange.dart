import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/routes/app_pages.dart';
import 'package:binance_cl/screens/app/home/controller/home_controller.dart';
import 'package:binance_cl/shared/action_button.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/shared/modal_header.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:binance_cl/utils/utilities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart' hide Trans;

class SelectExchangeType extends StatefulWidget {
  const SelectExchangeType({Key? key}) : super(key: key);

  @override
  State<SelectExchangeType> createState() => _SelectExchangeTypeState();
}

class _SelectExchangeTypeState extends State<SelectExchangeType> {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            SizedBox(height: heightSize(10)),
            ModalHeader(
              backCallback: () {},
              closeCallback: () {
                Get.back();
              },
              title: "selexsev".tr(),
              showCloseButton: false,
              showBackButton: false,
            ),
            SizedBox(height: heightSize(18)),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      homeController.selectFiatToCrypto();
                      setState(() {});
                    },
                    child: Container(
                      height: heightSize(200),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: homeController.fiatToCryptoSelected.value == true
                            ? kPrimaryColor
                            : kContainerColor,
                        borderRadius: BorderRadius.circular(Values().boxRadius),
                      ),
                      child: Column(
                        children: [
                           CText(
                            text: "fiat".tr(),
                            size: 20,
                            fontFamily: "Poppins-SemiBold",
                          ),
                          SizedBox(height: heightSize(2)),
                           CText(
                            text: "pywicd".tr(),
                            size: 12,
                            color: kText2Color,
                          ),
                          const Spacer(),
                          const Icon(Entypo.cycle),
                          const Spacer(),
                           CText(
                            text: "tcryp".tr(),
                            size: 20,
                            fontFamily: "Poppins-SemiBold",
                          ),
                          SizedBox(height: heightSize(2)),
                           CText(
                            text: "bycryp".tr(),
                            size: 12,
                            color: kText2Color,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: widthSize(10)),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      homeController.selectCryptoToCrypto();
                      setState(() {});
                    },
                    child: Container(
                      height: heightSize(200),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color:
                            homeController.cryptoToCryptoSelected.value == true
                                ? kPrimaryColor
                                : kContainerColor,
                        borderRadius: BorderRadius.circular(Values().boxRadius),
                      ),
                      child: Column(
                        children: [
                           CText(
                            text: "crypto".tr(),
                            size: 20,
                            fontFamily: "Poppins-SemiBold",
                          ),
                          SizedBox(height: heightSize(2)),
                           CText(
                            text: "contocryp".tr(),
                            size: 12,
                            color: kText2Color,
                          ),
                          const Spacer(),
                          const Icon(Entypo.cycle),
                          const Spacer(),
                           CText(
                            text: "tcryp".tr(),
                            size: 20,
                            fontFamily: "Poppins-SemiBold",
                          ),
                          SizedBox(height: heightSize(2)),
                           CText(
                            text: "toanocryp".tr(),
                            size: 12,
                            color: kText2Color,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(children: [
                Expanded(
                  flex: 3,
                  child: ActionButton(
                    text: "cncl".tr(),
                    color: kContainerColor,
                    callback: () {
                      Get.back();
                    },
                  ),
                ),
                SizedBox(width: widthSize(10)),
                Expanded(
                  flex: 7,
                  child: Obx(
                    () => ActionButton(
                      text: "cont".tr(),
                      color:
                          homeController.cryptoToCryptoSelected.value == false
                              ? kContainerColor
                              : kPrimaryColor,
                      callback: () {
                        if (homeController.cryptoToCryptoSelected.value ==
                            true) {
                          Get.back();
                          Get.toNamed(Routes.CRYPTO_TO_CRYPTO_SELECTOR);
                        } else {
                          showHelpSnackBar(
                              context: context,
                              title: "Oh Snap!",
                              messages: "Content not available at the moment.");
                        }
                      },
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
