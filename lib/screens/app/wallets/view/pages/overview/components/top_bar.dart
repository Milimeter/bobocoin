import 'dart:async';

import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/routes/app_pages.dart';
import 'package:binance_cl/screens/app/wallets/controller/balance_controller.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart' hide Trans;

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  BalanceController balanceController = Get.find();
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      balanceController.configureGetEquivalentBalanceRequest();
    });
  }

  bool hide = false;
  viewEquity() {
    setState(() {
      hide = !hide;
    });
  }

  @override
  Widget build(BuildContext context) {
    balanceController.configureGetEquivalentBalanceRequest();
    return Container(
      height: heightSize(190),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: kBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CText(
                  text: "Total Equity (BTC): ",
                  color: kText2Color,
                ),
                SizedBox(width: widthSize(10)),
                GestureDetector(
                  onTap: () {
                    viewEquity();
                  },
                  child: Icon(
                    hide == false ? Entypo.eye : Entypo.eye_with_line,
                    color: kText2Color,
                    size: 20,
                  ),
                )
              ],
            ),
            SizedBox(height: heightSize(10)),
            hide == false
                ? Obx(
                    () => CText(
                      text: "\$${balanceController.equivalentBalance.value}",
                      color: kPrimaryColor,
                      size: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : const CText(
                    text: "*********",
                    color: kPrimaryColor,
                    size: 30,
                    fontWeight: FontWeight.w600,
                  ),
            SizedBox(height: heightSize(10)),
            Row(
              children: [
                const CText(
                  text: "~ 0.0 USD ",
                  color: kText2Color,
                ),
                SizedBox(width: widthSize(10)),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Entypo.info_with_circle,
                    color: kText2Color,
                    size: 20,
                  ),
                )
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.DEPOSIT_SELECTOR);
                    },
                    child: Container(
                      height: heightSize(40),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius:
                            BorderRadius.circular(Values().boxRadius2),
                      ),
                      child: const Center(
                        child: CText(
                          text: "Deposit",
                          color: kBlackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: widthSize(20)),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.WITHDRAWAL_SELECTOR);
                    },
                    child: Container(
                      height: heightSize(40),
                      decoration: BoxDecoration(
                        color: kText2Color,
                        borderRadius:
                            BorderRadius.circular(Values().boxRadius2),
                      ),
                      child: const Center(
                        child: CText(
                          text: "Withdraw",
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: widthSize(20)),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.INTERNAL_TRANSFER);
                    },
                    child: Container(
                      height: heightSize(40),
                      decoration: BoxDecoration(
                        color: kText2Color,
                        borderRadius:
                            BorderRadius.circular(Values().boxRadius2),
                      ),
                      child: const Center(
                        child: CText(
                          text: "Transfer",
                          color: kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
