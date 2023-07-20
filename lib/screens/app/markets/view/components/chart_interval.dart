import 'package:binance_cl/screens/app/markets/controller/markets_controller.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class ChartInterval extends StatefulWidget {
  final double width, height;
  const ChartInterval({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  State<ChartInterval> createState() => _ChartIntervalState();
}

class _ChartIntervalState extends State<ChartInterval> {
  List<String> intervals = [
    "1m",
    "3m",
    "5m",
    "15m",
    "30m",
    "1h",
    "2h",
    "4h",
    "6h",
    "8h",
    "12h",
    "1d",
    "3d",
    "1w",
    "1M",
  ];
  MarketsController marketsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListView(
          key: const PageStorageKey<String>('controllerA'),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          children: [
            ...intervals.map((e) => item(text: e)).toList(),
          ],
        ),
      ),
    );
  }

  Widget item({required String text}) {
    bool isSelected = marketsController.binanceInterval.value == text;
    return GestureDetector(
      onTap: () {
        marketsController.binanceInterval.value = text;
        marketsController.setCandles();
        setState(() {});
      },
      child: Container(
        height: widget.height,
        width: widthSize(40),
        //padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(right: 4),

        child: Center(
          child: CText(
            text: text,
            size: 12,
            color: isSelected ? kPrimaryColor : kText2Color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
