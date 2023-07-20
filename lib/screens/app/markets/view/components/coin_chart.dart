// ignore_for_file: invalid_use_of_protected_member

import 'package:binance_cl/screens/app/markets/controller/markets_controller.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:candlesticks_plus/candlesticks_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class CoinChart extends StatefulWidget {
  final double width, height;
  const CoinChart({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  State<CoinChart> createState() => _CoinChartState();
}

class _CoinChartState extends State<CoinChart> {
  MarketsController marketsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Obx(
        () => marketsController.chartsError.value == false
            ? Candlesticks(
                candles: marketsController.candles.value,
                showToolbar: true,
                watermark: 'BoBocoin',
                onLoadMoreCandles: () async {
                  marketsController.candles.value
                      .addAll(marketsController.candles.value.sublist(0, 100));
                },
              )
            :  Center(
                child: CText(
                  text: "uncoinpir".tr(),
                  color: kPrimaryColor,
                ),
              ),
      ),
    );
  }
}
