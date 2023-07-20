// ignore_for_file: prefer_adjacent_string_concatenation, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:binance_cl/routes/app_pages.dart';
import 'package:binance_cl/screens/app/markets/controller/markets_controller.dart';
import 'package:binance_cl/screens/app/markets/view/components/change_price_triangle.dart';
import 'package:binance_cl/screens/app/markets/view/components/sparkline_widget.dart'
    hide Trans;
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coingecko_api/data/market.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class CoinInfoBox extends StatefulWidget {
  final String coinName;
  final double currentPrice, priceChangePercentage, marketCap;
  final String imageUrl;
  final int coinIndex;
  final String symbol;
  final String fiatCurrency;
  final String id;
  final Market selectedAsset;
  const CoinInfoBox({
    Key? key,
    required this.coinName,
    required this.currentPrice,
    required this.imageUrl,
    required this.coinIndex,
    required this.symbol,
    required this.priceChangePercentage,
    required this.marketCap,
    required this.fiatCurrency,
    required this.id,
    required this.selectedAsset,
  }) : super(key: key);

  @override
  State<CoinInfoBox> createState() => _CoinInfoBoxState();
}

class _CoinInfoBoxState extends State<CoinInfoBox> {
  MarketsController marketsController = Get.find();
  final List<FlSpot> flSpotList = <FlSpot>[];

  final List<double> newSparkline = <double>[];

  double i = 0;
  getSpakline() async {
    log("id: ${widget.id}");
    List<double> sparkline =
        await marketsController.getSparkLinePrice(id: widget.id);
    for (var price in sparkline) {
      i++;
      newSparkline.add(price);
      flSpotList.add(FlSpot(i, price));
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getSpakline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: GestureDetector(
        onTap: () {
          marketsController.selectedAsset = Rx(widget.selectedAsset);
          marketsController.binancePair.value =
              marketsController.selectedAsset!.value.symbol.toUpperCase() +
                  "USDT";
          log(marketsController.binancePair.value);
          marketsController.setCandles();
          Get.toNamed(Routes.MARKET_INFORMATION);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Image.network(
                    //   widget.imageUrl,
                    //   width: heightSize(40),
                    //   height: widthSize(40),
                    // ),
                    CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      width: heightSize(40),
                      height: widthSize(40),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                        value: downloadProgress.progress,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          kText2Color,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: kText2Color,
                      ),
                    ),
                    SizedBox(width: widthSize(8)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Container(
                        //   child: widget.coinName.length > 12
                        //       ? Text(
                        //           widget.coinName.replaceRange(
                        //             12,
                        //             widget.coinName.length,
                        //             '...',
                        //           ),
                        //           style: TextStyle(
                        //             fontSize: fontSize(18),
                        //             fontWeight: FontWeight.w600,
                        //           ).copyWith(color: Theme.of(context).hintColor),
                        //         )
                        //       : Text(
                        //           widget.coinName,
                        //           style: TextStyle(
                        //             fontSize: fontSize(18),
                        //             fontWeight: FontWeight.w600,
                        //           ).copyWith(color: Theme.of(context).hintColor),
                        //         ),
                        // ),
                        Container(
                          child: widget.coinName.length > 12
                              ? CText(
                                  text: widget.coinName.replaceRange(
                                    12,
                                    widget.coinName.length,
                                    '...',
                                  ),
                                  size: 18,
                                  fontFamily: "Poppins-SemiBold",
                                )
                              : CText(
                                  text: widget.coinName,
                                  size: 18,
                                  fontFamily: "Poppins-SemiBold",
                                ),
                        ),
                        SizedBox(height: heightSize(6)),
                        Row(
                          children: <Widget>[
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              decoration: const BoxDecoration(
                                color: Color(0xFF3D3C3A),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Text(
                                '${widget.coinIndex + 1}',
                                style: TextStyle(
                                  fontSize: fontSize(11),
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFF7F7F7),
                                ),
                              ),
                            ),
                            SizedBox(width: widthSize(4)),
                            // Text(
                            //   widget.symbol.toUpperCase(),
                            //   style: TextStyle(
                            //     fontSize: fontSize(11),
                            //     fontWeight: FontWeight.w600,
                            //     color: const Color(0xFFA19999),
                            //   ),
                            // ),
                            CText(
                              text: widget.symbol.toUpperCase(),
                              color: kText2Color,
                              size: 14,
                            ),
                            ChangePriceTriangle(
                              priceChangePercentage:
                                  widget.priceChangePercentage,
                              fontSize: fontSize(18),
                              textStyle: TextStyle(
                                fontSize: fontSize(11),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFA19999),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            newSparkline.isEmpty
                ? SizedBox(height: heightSize(40))
                : SizedBox(
                    height: heightSize(40),
                    child: AbsorbPointer(
                      absorbing: true,
                      child: SparklineWidget( 
                        sparkline: newSparkline,
                        flSpotList: flSpotList,
                        showBarArea: false,
                        pricePercentage: widget.priceChangePercentage,
                      ),
                    ),
                  ),
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      widget.currentPrice.toStringAsFixed(2) +
                          ' ' +
                          widget.fiatCurrency.toUpperCase(),
                      style: TextStyle(
                        fontSize: fontSize(14),
                        fontWeight: FontWeight.w400,
                      ).copyWith(color: kTextColor),
                    ),
                    SizedBox(height: heightSize(6)),
                    Text(
                      widget.marketCap > 1000000000000
                          ? ' ${'MCap' + ' ' + (widget.marketCap / 1000000000).toStringAsFixed(2) + ' ' + widget.fiatCurrency.toUpperCase()} T'
                          : ' ${'MCap' + ' ' + (widget.marketCap / 1000000000).toStringAsFixed(2) + ' ' + widget.fiatCurrency.toUpperCase()} Bn',
                      style: TextStyle(
                        fontSize: fontSize(11),
                        fontWeight: FontWeight.w400,
                        color: kText2Color,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
