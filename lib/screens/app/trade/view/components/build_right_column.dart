import 'dart:async';

import 'package:binance_cl/screens/app/trade/controller/trade_controller.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart' hide Trans;

class BuildRightColumn extends StatefulWidget {
  const BuildRightColumn({Key? key}) : super(key: key);

  @override
  State<BuildRightColumn> createState() => _BuildRightColumnState();
}

class _BuildRightColumnState extends State<BuildRightColumn> {
  TradeController tradeController = Get.find();
  late Timer timer;

  @override
  void initState() {
    tradeController.getBinanceSymbolOrderBook();
    startTimer();
    super.initState();
  }

  _handleOrderBookRefresh() {
    tradeController.getBinanceSymbolOrderBook();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 1000), (t) {
      setState(() {
        _handleOrderBookRefresh();
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
    return Obx(
      () => Column(
        children: [
          SizedBox(height: heightSize(10)),
          SizedBox(
            height: heightSize(180),
            child: ListView.builder(
              itemCount: tradeController.orderBook.value.asks!.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: size.width *
                          double.parse(tradeController
                              .orderBook.value.asks![index].last),
                      height: heightSize(25),
                      color: Colors.red.withOpacity(0.2),
                    ),
                    Row(
                      children: [
                        CText(
                          text: double.parse(tradeController
                                  .orderBook.value.asks![index].first)
                              .toStringAsFixed(5),
                          color: const Color(0xFFFF3232),
                          size: 14,
                        ),
                        const Spacer(),
                        CText(
                          text: double.parse(tradeController
                                  .orderBook.value.asks![index].last)
                              .toStringAsFixed(3),
                          color: kGreyColor,
                          size: 14,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: heightSize(10)),
          Align(
            alignment: Alignment.centerLeft,
            child: CText(
              text: double.parse(tradeController.orderTickerPrice.value)
                  .toStringAsFixed(6),
              color: tradeController.isBuySelected.value
                  ? kUptrendColor
                  : const Color(0xFFFF3232),
              size: 18,
            ),
          ),
          SizedBox(height: heightSize(5)),
          Align(
            alignment: Alignment.centerLeft,
            child: CText(
              text:
                  "~${double.parse(tradeController.orderTickerPrice.value).toStringAsFixed(2)}",
              color: kText2Color,
              size: 16,
            ),
          ),
          SizedBox(height: heightSize(13)),
          SizedBox(
            height: heightSize(180),
            child: ListView.builder(
              itemCount: tradeController.orderBook.value.bids!.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      width: size.width *
                          double.parse(tradeController
                              .orderBook.value.bids![index].last),
                      height: heightSize(25),
                      color: kUptrendColor.withOpacity(0.2),
                    ),
                    Row(
                      children: [
                        CText(
                          text: double.parse(tradeController
                                  .orderBook.value.bids![index].first)
                              .toStringAsFixed(5),
                          color: kUptrendColor,
                          size: 14,
                        ),
                        const Spacer(),
                        CText(
                          text: double.parse(tradeController
                                  .orderBook.value.bids![index].last)
                              .toStringAsFixed(3),
                          color: kGreyColor,
                          fontFamily: "Poppins-SemiBold",
                          size: 14,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
