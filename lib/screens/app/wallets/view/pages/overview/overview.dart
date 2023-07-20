import 'dart:async';
import 'dart:developer';

import 'package:binance_cl/constants/tradeable_assets.dart';
import 'package:binance_cl/screens/app/markets/controller/markets_controller.dart';
import 'package:binance_cl/screens/app/wallets/controller/balance_controller.dart';
import 'package:binance_cl/screens/app/wallets/view/pages/overview/components/top_bar.dart';
import 'package:binance_cl/screens/app/wallets/view/pages/overview/modals/crypto_info.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:binance_cl/utils/utilities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/data/market.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  MarketsController marketsController = Get.find();
  BalanceController balanceController = Get.find();
  CoinGeckoApi coinGeckoApi = CoinGeckoApi();
  List<Market> myAssets = <Market>[];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    if (marketsController.coinList != null) {
      myAssets = List.from(marketsController.coinList!.data);
      myAssets.removeWhere((asset) =>
          TradeableAssets.useableAssets.contains(asset.symbol.toUpperCase()) ==
          false);
    } else if (myAssets.isEmpty) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (myAssets.isNotEmpty) {
          timer.cancel();
        }
        if (mounted) {
          setState(() {});
        }
        log('calling state');
      });
    }
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(18),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: kBlackColor,
                  ),
                  child: Column(
                    children: [
                      // item(
                      //   title: "Spot Account",
                      //   amountInBTC: "0.00000000",
                      //   amountInUSDT: "0.00",
                      // ),
                      // item(
                      //   title: "Futures Account",
                      //   amountInBTC: "0.00000000",
                      //   amountInUSDT: "0.00",
                      // ),
                      // item(
                      //   title: "P2P Account",
                      //   amountInBTC: "0.00000000",
                      //   amountInUSDT: "0.00",
                      // ),
                      // item(
                      //   title: "Margin Account",
                      //   amountInBTC: "0.00000000",
                      //   amountInUSDT: "0.00",
                      // ),
                      myAssets.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: myAssets.length,
                                itemBuilder: (context, index) {
                                  return coinItem(
                                      assetLogo: myAssets[index].image!,
                                      trendColor: myAssets[index]
                                              .priceChangePercentage24h
                                              .toString()
                                              .contains('-')
                                          ? kDowntrendColor
                                          : kUptrendColor,
                                      title: myAssets[index].name == "BNB"
                                          ? "BNB Smart Chain"
                                          : myAssets[index].name,
                                      subtitle:
                                          "${myAssets[index].symbol.toUpperCase()} ",
                                      inUSD: balanceController.balances[
                                          myAssets[index].symbol.toUpperCase()],
                                      assetPercentage:
                                          "${myAssets[index].priceChangePercentage24h!.toStringAsFixed(2)}%",
                                      isTradeable: TradeableAssets.allowedAssets
                                              .contains(myAssets[index]
                                                  .symbol
                                                  .toUpperCase())
                                          ? true
                                          : false,
                                      callback: () {
                                        modalSetup(
                                          context,
                                          modalPercentageHeight: 0.90,
                                          createPage: CryptoInfoModal(
                                              symbol: myAssets[index]
                                                  .symbol
                                                  .toUpperCase()),
                                          showBarrierColor: true,
                                        );
                                        // dashboardController
                                        //         .binancePair.value =
                                        //     '${myAssets[index].symbol.toUpperCase()}USDT';
                                        // log(dashboardController
                                        //     .binancePair.value);
                                        // dashboardController.setCandles();
                                        // Get.toNamed(Routes.CRYPTO_ASSET_INFO,
                                        //     arguments: {
                                        //       "symbol": myAssets[index]
                                        //           .symbol
                                        //           .toUpperCase(),
                                        //     });
                                      });
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget item(
      {required String title,
      required String amountInBTC,
      required String amountInUSDT}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CText(
                text: title,
                color: kWhiteColor,
                size: 16,
              ),
              SizedBox(height: heightSize(20)),
              const CText(
                text: "Equity",
                color: kText2Color,
                size: 14,
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CText(
                text: "$amountInBTC BTC",
                color: kWhiteColor,
                size: 16,
              ),
              SizedBox(height: heightSize(20)),
              CText(
                text: "$amountInUSDT USD",
                color: kText2Color,
                size: 14,
              ),
            ],
          ),
          SizedBox(width: widthSize(10)),
          const Icon(
            Icons.arrow_forward_ios,
            color: kText2Color,
            size: 15,
          ),
        ],
      ),
    );
  }

  Widget coinItem({
    required String assetLogo,
    required String title,
    required String subtitle,
    required String inUSD,
    required String assetPercentage,
    required Color trendColor,
    required bool isTradeable,
    required VoidCallback callback,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: heightSize(80),
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  child: CachedNetworkImage(
                    imageUrl: assetLogo,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                         
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                SizedBox(width: widthSize(15)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CText(
                      text: title,
                      color: kWhiteColor,
                      size: 16,
                    ),
                    SizedBox(height: heightSize(15)),
                    CText(
                      text: "${subtitle.trim()}/USD",
                      color: kPrimaryColor,
                      size: 15,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CText(
                      text: "\$$inUSD",
                      color: kPrimaryColor,
                      size: 16,
                    ),
                    SizedBox(height: heightSize(15)),
                    CText(
                      text: assetPercentage,
                      color: trendColor,
                      size: 14,
                    ),
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
