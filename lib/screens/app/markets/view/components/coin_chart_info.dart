import 'package:binance_cl/screens/app/markets/controller/markets_controller.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:binance_cl/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart' hide Trans;

class CoinMarketInfo extends StatefulWidget {
  const CoinMarketInfo({Key? key}) : super(key: key);

  @override
  State<CoinMarketInfo> createState() => _CoinMarketInfoState();
}

class _CoinMarketInfoState extends State<CoinMarketInfo> {
  MarketsController marketsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Entypo.list,
                color: kWhiteColor,
                size: 20,
              ),
              SizedBox(width: widthSize(6)),
              CText(
                text:
                    "${marketsController.selectedAsset!.value.symbol.toUpperCase()}USD",
                color: kWhiteColor,
                fontWeight: FontWeight.w500,
                size: 20,
              ),
              SizedBox(width: widthSize(4)),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: marketsController
                              .selectedAsset!.value.priceChangePercentage24h! >
                          0
                      ? kUptrend2Color.withOpacity(0.1)
                      : const Color(0xFFFF3B30).withOpacity(0.1),
                ),
                child: CText(
                  text:
                      "${marketsController.selectedAsset!.value.priceChangePercentage24h!.toStringAsFixed(2)}%",
                  color: marketsController
                              .selectedAsset!.value.priceChangePercentage24h! >
                          0
                      ? kUptrend2Color
                      : const Color(0xFFFF3B30),
                  size: 11,
                ),
              )
            ],
          ),
          SizedBox(height: heightSize(16)),
          SizedBox(
            //height: heightSize(80),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText(
                  text: "\$",
                  size: 20,
                  fontWeight: FontWeight.w600,
                  color: marketsController
                              .selectedAsset!.value.priceChangePercentage24h! >
                          0
                      ? kUptrend2Color
                      : const Color(0xFFFF3B30),
                ),
                SizedBox(width: widthSize(5)),
                CText(
                  text: formatMoney(
                      marketsController.selectedAsset!.value.currentPrice),
                  size: 34,
                  fontWeight: FontWeight.w600,
                  color: marketsController
                              .selectedAsset!.value.priceChangePercentage24h! >
                          0
                      ? kUptrend2Color
                      : kDowntrendColor,
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CText(
                          text: "24h High",
                          color: kText2Color,
                          size: 15,
                        ),
                        SizedBox(width: widthSize(15)),
                        //const Spacer(),
                        CText(
                          text: formatMoney(
                              marketsController.selectedAsset!.value.high24h),
                          color: kTextColor,
                          size: 15,
                        ),
                      ],
                    ),
                    SizedBox(height: heightSize(8)),
                    Row(
                      children: [
                        const CText(
                          text: "24h Low",
                          color: kText2Color,
                          size: 15,
                        ),
                        SizedBox(width: widthSize(15)),
                        CText(
                          text: formatMoney(
                              marketsController.selectedAsset!.value.low24h),
                          color: kTextColor,
                          size: 15,
                        ),
                      ],
                    ),
                    SizedBox(height: heightSize(8)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CText(
                          text: "Market Cap.",
                          color: kText2Color,
                          size: 15,
                        ),
                        SizedBox(width: widthSize(15)),
                        CText(
                          text: numberFormat(marketsController
                              .selectedAsset!.value.marketCap!),
                          color: kTextColor,
                          size: 15,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
