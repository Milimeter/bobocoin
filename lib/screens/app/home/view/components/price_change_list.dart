// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:binance_cl/screens/app/home/controller/home_controller.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class PriceChangeList extends StatefulWidget {
  const PriceChangeList({super.key});

  @override
  State<PriceChangeList> createState() => _PriceChangeListState();
}

class _PriceChangeListState extends State<PriceChangeList> {
  HomeController homeController = Get.find();
  late Timer timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  _handlePriceChangeRefresh() {
    homeController.getBinanceCryptoTicker();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 3000), (t) {
      setState(() {
        _handlePriceChangeRefresh();
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.6,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Column(
          children: [
            Row(
              children: [
                 CText(
                  text: "trpir".tr(),
                  size: 14,
                  color: kText2Color,
                ),
                const Spacer(),
                 CText(
                  text: "prvl".tr(),
                  size: 14,
                  color: kText2Color,
                ),
                SizedBox(width: widthSize(30)),
                 CText(
                  text: "24ch".tr(),
                  size: 14,
                  color: kText2Color,
                ),
              ],
            ),
            SizedBox(height: heightSize(15)),
            Expanded(
                child: Obx(
              () => ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount:
                    homeController.cryptoPriceChangeStatistics.value.length,
                itemBuilder: (context, index) {
                  return priceChangeItem(
                    symbol: homeController
                        .cryptoPriceChangeStatistics.value[index].symbol!,
                    priceChangePercent: homeController
                        .cryptoPriceChangeStatistics
                        .value[index]
                        .priceChangePercent!,
                    lastPrice: homeController
                        .cryptoPriceChangeStatistics.value[index].lastPrice!,
                    volume: homeController
                        .cryptoPriceChangeStatistics.value[index].volume!,
                  );
                },
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget priceChangeItem({
    required String symbol,
    required String priceChangePercent,
    required String lastPrice,
    required String volume,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          // Container(
          //   height: heightSize(60),
          //   width: widthSize(60),
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     border: Border.all(
          //       color: priceChangePercent.contains("-")
          //           ? kDowntrendColor
          //           : kUptrend2Color,
          //     ),
          //   ),
          //   child: Center(
          //     child: CText(
          //       text: symbol[0],
          //       size: 16,
          //       color: kText2Color,
          //     ),
          //   ),
          // ),
          // SizedBox(width: widthSize(10)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CText(
                    text: symbol.substring(0, symbol.length - 4),
                    size: 17,
                  ),
                  const CText(
                    text: "/ USDT",
                    size: 14,
                    color: kText2Color,
                  ),
                ],
              ),
              SizedBox(height: heightSize(8)),
              CText(
                text: priceChangePercent.contains("-") ? "Short" : "Long",
                size: 14,
                color: priceChangePercent.contains("-")
                    ? kDowntrendColor
                    : kUptrend2Color,
              ),
            ],
          ),
          const Spacer(),
          CText(
            text: double.parse(lastPrice).toStringAsFixed(3),
            size: 16,
          ),
          SizedBox(width: widthSize(20)),
          Container(
            height: heightSize(30),
            width: widthSize(80),
            decoration: BoxDecoration(
              color: priceChangePercent.contains("-")
                  ? kDowntrendColor
                  : kUptrend2Color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: CText(
                text: "$priceChangePercent%",
                fontWeight: FontWeight.w600,
                color: kWhiteColor,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
