import 'dart:developer';

import 'package:binance_cl/constants/strings.dart';
import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/routes/app_pages.dart';
import 'package:binance_cl/screens/app/markets/controller/markets_controller.dart';
import 'package:binance_cl/screens/app/markets/view/components/sparkline_widget.dart';
import 'package:binance_cl/screens/app/wallets/controller/balance_controller.dart';
import 'package:binance_cl/services/storage.dart';
import 'package:binance_cl/shared/action_button.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:binance_cl/utils/utilities.dart';
import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/data/market.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class CryptoInfoModal extends StatefulWidget {
  final String symbol;
  const CryptoInfoModal({super.key, required this.symbol});

  @override
  State<CryptoInfoModal> createState() => _CryptoInfoModalState();
}

class _CryptoInfoModalState extends State<CryptoInfoModal> {
  MarketsController marketsController = Get.find();
  BalanceController balanceController = Get.find();
  CoinGeckoApi coinGeckoApi = CoinGeckoApi();
  late Market currentAsset;
  String mnemonics = '';
  String selectedWalletAddress = '';
  final List<FlSpot> flSpotList = <FlSpot>[];

  final List<double> newSparkline = <double>[];
  double i = 0;

  getSpakline() async {
    // log("id: ${widget.id}");
    List<double> sparkline =
        await marketsController.getSparkLinePrice(id: currentAsset.id);
    for (var price in sparkline) {
      i++;
      newSparkline.add(price);
      flSpotList.add(FlSpot(i, price));
    }
    if (mounted) {
      setState(() {});
    }
  }

  getAddress(symbol) async {
    mnemonics = await Storage.readData(WALLET_MNEMONICS);
    getWalletAddress(symbol: symbol);
  }

  @override
  void initState() {
    currentAsset = marketsController.coinList!.data
        .firstWhere((element) => element.symbol.toUpperCase() == widget.symbol);
    log(currentAsset.name);
    getAddress(widget.symbol.toUpperCase());
    getSpakline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(height: heightSize(20)),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: kBackgroundColor,
                      backgroundImage: NetworkImage(currentAsset.image!),
                    ),
                    SizedBox(width: widthSize(15)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: heightSize(5)),
                        CText(
                          text: currentAsset.name,
                          size: 18,
                          fontFamily: "Poppins-SemiBold",
                        ),
                        SizedBox(height: heightSize(10)),
                        CText(
                          text: currentAsset.symbol.toUpperCase(),
                          color: kText2Color,
                          size: 25,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: heightSize(5)),
                        CText(
                          text: "\$${formatMoney(currentAsset.currentPrice)}",
                          color: kText2Color,
                          size: 25,
                        ),
                        SizedBox(height: heightSize(10)),
                        CText(
                          text:
                              "${currentAsset.priceChangePercentage24h!.toStringAsFixed(2)}%",
                          color: currentAsset.priceChangePercentage24h! > 0
                              ? kUptrendColor
                              : const Color(0xFFFF3B30),
                          size: 14,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: heightSize(20)),
                const Divider(),
                SizedBox(height: heightSize(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    statItem(
                      title: "Low",
                      subtitle: formatMoney(currentAsset.low24h),
                    ),
                    statItem(
                      title: "High",
                      subtitle: formatMoney(currentAsset.high24h),
                    ),
                    statItem(
                      title: "Vol",
                      subtitle: formatMoney(currentAsset.totalVolume),
                    ),
                  ],
                ),
                SizedBox(height: heightSize(20)),
                Container(
                  height: constraints.maxHeight * 0.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kContainerColor,
                    borderRadius: BorderRadius.circular(Values().boxRadius),
                  ),
                  child: Stack(
                    children: [
                      newSparkline.isEmpty
                          ? const SpinKitRing(color: kPrimaryColor)
                          : SizedBox(
                              height: constraints.maxHeight * 0.5,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 8.0, left: 8.0),
                                child: AbsorbPointer(
                                  absorbing: true,
                                  child: SparklineWidget(
                                    sparkline: newSparkline,
                                    flSpotList: flSpotList,
                                    showBarArea: false,
                                    pricePercentage: num.parse(currentAsset
                                        .priceChangePercentage24h
                                        .toString()),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                SizedBox(height: heightSize(20)),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CText(
                    text: "Wallet Balance: ",
                    color: kText2Color,
                    size: 16,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CText(
                    text:
                        balanceController.balances[widget.symbol.toUpperCase()],
                    size: 18,
                    height: 1.5,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ActionButton(
                        text: "Buy",
                        callback: () {
                          Get.back();
                          Get.toNamed(Routes.BUY_CRYPTO_ASSET, arguments: {
                            "symbol": widget.symbol.toUpperCase(),
                            "walletAddress": selectedWalletAddress,
                          });
                        },
                        color: kUptrend2Color,
                      ),
                    ),
                    SizedBox(width: widthSize(10)),
                    Expanded(
                      child: ActionButton(
                        text: "Sell",
                        callback: () {
                          Get.back();
                          Get.toNamed(Routes.BUY_CRYPTO_ASSET, arguments: {
                            "symbol": widget.symbol.toUpperCase(),
                            "walletAddress": selectedWalletAddress,
                          });
                        },
                        color: kDowntrendColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: heightSize(20)),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget statItem({
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: heightSize(5)),
        CText(
          text: title,
          color: kText2Color,
          size: 12,
        ),
        SizedBox(height: heightSize(15)),
        CText(
          text: "\$${truncate(subtitle, length: 8)}",
          size: 18,
        ),
      ],
    );
  }

  getWalletAddress({required String symbol}) {
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    switch (symbol) {
      case 'ARATA':
        selectedWalletAddress =
            wallet.getAddressForCoin(TWCoinType.TWCoinTypeBitcoin);
        log(selectedWalletAddress);
        setState(() {});

        break;
      case 'BTC':
        selectedWalletAddress =
            wallet.getAddressForCoin(TWCoinType.TWCoinTypeBitcoin);
        log(selectedWalletAddress);
        setState(() {});

        break;
      case 'ETH':
        selectedWalletAddress =
            wallet.getAddressForCoin(TWCoinType.TWCoinTypeEthereum);
        log(selectedWalletAddress);
        setState(() {});

        break;
      case 'BNB':
        selectedWalletAddress =
            wallet.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain);
        log(selectedWalletAddress);
        setState(() {});

        break;
      case 'ADA':
        selectedWalletAddress =
            wallet.getAddressForCoin(TWCoinType.TWCoinTypeCardano);
        log(selectedWalletAddress);
        setState(() {});

        break;
      case 'XRP':
        selectedWalletAddress =
            wallet.getAddressForCoin(TWCoinType.TWCoinTypeXRP);
        log(selectedWalletAddress);
        setState(() {});

        break;
      case 'TRX':
        selectedWalletAddress =
            wallet.getAddressForCoin(TWCoinType.TWCoinTypeTron);
        log(selectedWalletAddress);
        setState(() {});

        break;
      case 'BCH':
        selectedWalletAddress =
            wallet.getAddressForCoin(TWCoinType.TWCoinTypeBitcoinCash);
        log(selectedWalletAddress);
        setState(() {});

        break;
      case 'DOGE':
        selectedWalletAddress =
            wallet.getAddressForCoin(TWCoinType.TWCoinTypeDogecoin);
        log(selectedWalletAddress);
        setState(() {});
        break;
      case 'MATIC':
        selectedWalletAddress =
            wallet.getAddressForCoin(TWCoinType.TWCoinTypePolygon);
        log(selectedWalletAddress);
        setState(() {});

        break;
      case 'XLM':
        selectedWalletAddress =
            wallet.getAddressForCoin(TWCoinType.TWCoinTypeStellar);
        log(selectedWalletAddress);
        setState(() {});

        break;
      case 'token':
        selectedWalletAddress =
            wallet.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain);
        log(selectedWalletAddress);
        setState(() {});

        break;

      default:
        selectedWalletAddress =
            wallet.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain);
        log(selectedWalletAddress);
        setState(() {});
    }
  }
}
