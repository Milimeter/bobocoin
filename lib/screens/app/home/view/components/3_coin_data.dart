// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:developer';

import 'package:binance_cl/screens/app/markets/controller/markets_controller.dart';
import 'package:binance_cl/screens/app/markets/view/components/sparkline_widget.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/data/market.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class ThreeCoinData extends StatefulWidget {
  const ThreeCoinData({Key? key}) : super(key: key);

  @override
  State<ThreeCoinData> createState() => _ThreeCoinDataState();
}

class _ThreeCoinDataState extends State<ThreeCoinData> {
  CoinGeckoApi api = CoinGeckoApi();
  List<Market> myAssets = <Market>[];
  MarketsController marketsController = Get.find();
  final List<FlSpot> flSpotList0 = <FlSpot>[];
  final List<double> newSparkline0 = <double>[];
  final List<FlSpot> flSpotList1 = <FlSpot>[];
  final List<double> newSparkline1 = <double>[];
  final List<FlSpot> flSpotList2 = <FlSpot>[];
  final List<double> newSparkline2 = <double>[];
  double i0 = 0;
  double i1 = 0;
  double i2 = 0;
  getSparkline0() async {
    List<double> sparkline =
        await marketsController.getSparkLinePrice(id: 'bitcoin'); 
    for (var price in sparkline) {
      i0++;
      newSparkline0.add(price);
      flSpotList0.add(FlSpot(i0, price));
    }
    if (mounted) {
      setState(() {});
    }
  }

  getSparkline1() async {
    List<double> sparkline =
        await marketsController.getSparkLinePrice(id: 'ethereum');
    for (var price in sparkline) {
      i1++;
      newSparkline1.add(price);
      flSpotList1.add(FlSpot(i1, price));
    }
    if (mounted) {
      setState(() {});
    }
  }

  getSparkline2() async {
    List<double> sparkline =
        await marketsController.getSparkLinePrice(id: 'binancecoin');
    for (var price in sparkline) {
      i2++;
      newSparkline2.add(price);
      flSpotList2.add(FlSpot(i2, price));
    }
    if (mounted) {
      setState(() {});
    }
  }

  getData() {
    Timer(const Duration(seconds: 4), () {
      if (marketsController.coinList != null) {
        if (marketsController.coinList!.data.isNotEmpty) {
          myAssets = List.from(marketsController.coinList!.data);
          myAssets.removeWhere((asset) =>
              ['BNB', 'BTC', 'ETH'].contains(asset.symbol.toUpperCase()) ==
              false);
          if (mounted) {
            setState(() {});
          }
        } else {
          Timer(const Duration(seconds: 1), () {
            log("calling state");
            if (mounted) {
              setState(() {});
            }
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    getSparkline0();
    getSparkline1();
    getSparkline2();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Container(
      height: heightSize(150),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: kContainerColor,
        border: Border.all(color: kGreyColor.withOpacity(0.1)),
      ),
      child: myAssets.isEmpty
          ? const SizedBox.shrink()
          : Row(
              children: [
                Expanded(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          text: "${myAssets[0].symbol.toUpperCase()}/USDT",
                          size: 20,
                        ),
                        SizedBox(height: heightSize(5)),
                        CText(
                          text: myAssets[0].marketCap! > 1000000000000
                              ? '${(myAssets[0].marketCap! / 1000000000).toStringAsFixed(2) + ' ' + 'USD'} T'
                              : '${(myAssets[0].marketCap! / 1000000000).toStringAsFixed(2) + ' ' + 'USD'} Bn',
                          size: 13,
                          fontFamily: "Poppins-SemiBold",
                          color: kUptrend2Color,
                        ),
                        const Spacer(),
                        newSparkline0.isEmpty
                            ? SizedBox(height: heightSize(40))
                            : SizedBox(
                                height: heightSize(40),
                                child: AbsorbPointer(
                                  absorbing: true,
                                  child: SparklineWidget(
                                    sparkline: newSparkline0,
                                    flSpotList: flSpotList0,
                                    showBarArea: false,
                                    pricePercentage:
                                        myAssets[0].priceChangePercentage24h!,
                                  ),
                                ),
                              ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: widthSize(10)),
                Expanded(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          text: "${myAssets[1].symbol.toUpperCase()}/USDT",
                          size: 20,
                          fontFamily: "Poppins-SemiBold",
                        ),
                        SizedBox(height: heightSize(5)),
                        CText(
                          text: myAssets[1].marketCap! > 1000000000000
                              ? '${(myAssets[1].marketCap! / 1000000000).toStringAsFixed(2) + ' ' + 'USD'} T'
                              : '${(myAssets[1].marketCap! / 1000000000).toStringAsFixed(2) + ' ' + 'USD'} Bn',
                          size: 13,
                          fontFamily: "Poppins-SemiBold",
                          color: kUptrend2Color,
                        ),
                        const Spacer(),
                        newSparkline1.isEmpty
                            ? SizedBox(height: heightSize(40))
                            : SizedBox(
                                height: heightSize(40),
                                child: AbsorbPointer(
                                  absorbing: true,
                                  child: SparklineWidget(
                                    sparkline: newSparkline1,
                                    flSpotList: flSpotList1,
                                    showBarArea: false,
                                    pricePercentage:
                                        myAssets[1].priceChangePercentage24h!,
                                  ),
                                ),
                              ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: widthSize(10)),
                Expanded(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText(
                          text: "${myAssets[2].symbol.toUpperCase()}/USDT",
                          size: 20,
                          fontFamily: "Poppins-SemiBold",
                        ),
                        SizedBox(height: heightSize(5)),
                        CText(
                          text: myAssets[2].marketCap! > 1000000000000
                              ? '${(myAssets[2].marketCap! / 1000000000).toStringAsFixed(2) + ' ' + 'USD'} T'
                              : '${(myAssets[2].marketCap! / 1000000000).toStringAsFixed(2) + ' ' + 'USD'} Bn',
                          size: 13,
                          fontFamily: "Poppins-SemiBold",
                          color: kUptrend2Color,
                        ),
                        const Spacer(),
                        newSparkline2.isEmpty
                            ? SizedBox(height: heightSize(40))
                            : SizedBox(
                                height: heightSize(40),
                                child: AbsorbPointer(
                                  absorbing: true,
                                  child: SparklineWidget(
                                    sparkline: newSparkline2,
                                    flSpotList: flSpotList2,
                                    showBarArea: false,
                                    pricePercentage:
                                        myAssets[2].priceChangePercentage24h!,
                                  ),
                                ),
                              ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
