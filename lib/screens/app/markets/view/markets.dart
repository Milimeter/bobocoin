import 'package:binance_cl/screens/app/markets/controller/markets_controller.dart';
import 'package:binance_cl/screens/app/markets/view/components/coin_info_box.dart';
import 'package:binance_cl/screens/app/markets/view/components/shimmer_coin_info_box.dart';

import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:coingecko_api/coingecko_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

import 'components/top_action.dart';

class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  MarketsController marketsController = Get.find();
  CoinGeckoApi coinGeckoApi = CoinGeckoApi();
  String fiatCurrency = 'usd';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.02), 
                  const TopAction(),
                  SizedBox(height: heightSize(20)),
                  Expanded(
                    child: Obx(
                      () => marketsController.loadingData.value == true
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 15,
                              itemBuilder: (BuildContext context, int index) {
                                return const ShimmerCoinInfoBox();
                              },
                            )
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount:
                                  marketsController.coinList!.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CoinInfoBox(
                                  coinIndex: index,
                                  selectedAsset:
                                      marketsController.coinList!.data[index],
                                  id: marketsController
                                      .coinList!.data[index].id,
                                  coinName: marketsController
                                      .coinList!.data[index].name,
                                  currentPrice: marketsController
                                      .coinList!.data[index].currentPrice!,
                                  imageUrl: marketsController
                                      .coinList!.data[index].image!,
                                  symbol: marketsController
                                      .coinList!.data[index].symbol,
                                  priceChangePercentage: marketsController
                                      .coinList!
                                      .data[index]
                                      .priceChangePercentage24h!,
                                  marketCap: marketsController
                                      .coinList!.data[index].marketCap!,
                                  fiatCurrency: fiatCurrency.toString(),
                                );
                              },
                            ),
                    ),
                  )
                
                ],
              );
            }),
          ),
        ));
  }
}
