import 'package:anim_search_app_bar/anim_search_app_bar.dart';
import 'package:binance_cl/constants/tradeable_assets.dart';
import 'package:binance_cl/routes/app_pages.dart';
import 'package:binance_cl/screens/app/markets/controller/markets_controller.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/data/market.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class WithdrawalSelector extends StatefulWidget {
  const WithdrawalSelector({Key? key}) : super(key: key);

  @override
  State<WithdrawalSelector> createState() => _WithdrawalSelectorState();
}

class _WithdrawalSelectorState extends State<WithdrawalSelector> {
  MarketsController marketsController = Get.find();
  TextEditingController textEditingController = TextEditingController();
  CoinGeckoApi coinGeckoApi = CoinGeckoApi();

  late List<Market> filteredCryptoAssets = [];
  List<Market> myAssets = <Market>[];

  @override
  void initState() {
    myAssets = marketsController.coinList!.data;
    myAssets.removeWhere((asset) =>
        TradeableAssets.useableAssets.contains(asset.symbol.toUpperCase()) ==
        false);
    filteredCryptoAssets = myAssets;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Market> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = marketsController.coinList!.data;
    } else {
      results = marketsController.coinList!.data
          .where((asset) =>
              asset.name.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              asset.symbol.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      filteredCryptoAssets = results;
    });
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
                //SizedBox(height: constraints.maxHeight * 0.03),
                AnimSearchAppBar(
                  cSearch: textEditingController,
                  backgroundColor: kContainerColor,
                  appBar: AppBar(
                    backgroundColor: kContainerColor,
                    automaticallyImplyLeading: false,
                    title: CText(
                      text: "srchtrst".tr(),
                      size: 18,
                      fontFamily: "Poppins-SemiBold",
                    ),
                  ),
                  decoration: InputDecoration(
                    hintText: "Search here",
                    fillColor: kGreyColor.withOpacity(0.3),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(
                        6,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                      borderRadius: BorderRadius.circular(
                        6,
                      ),
                    ),
                  ),
                  onChanged: (value) => _runFilter(value),
                  cancelButtonText: "cncl".tr(),
                  hintText: 'srch'.tr(),
                ),
                SizedBox(height: heightSize(20)),
                Expanded(
                  child: filteredCryptoAssets.isNotEmpty
                      ? ListView.builder(
                          itemCount: filteredCryptoAssets.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.WITHDRAWAL_AMOUNT_INPUT, arguments: {
                                "symbol": filteredCryptoAssets[index]
                                    .symbol
                                    .toUpperCase(),
                                "name": filteredCryptoAssets[index].name,
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 28),
                              child: Row(
                                key: ValueKey(filteredCryptoAssets[index].id),
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          filteredCryptoAssets[index].image!,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            // colorFilter: ColorFilter.mode(
                                            //     Colors.red, BlendMode.colorBurn),
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  SizedBox(width: widthSize(16)),
                                  CText(
                                    text: filteredCryptoAssets[index]
                                        .symbol
                                        .toUpperCase(),
                                    size: 18,
                                    fontFamily: "Poppins-SemiBold",
                                  ),
                                  SizedBox(width: widthSize(6)),
                                  CText(
                                    text: filteredCryptoAssets[index].name,
                                    size: 14,
                                    color: kText2Color,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Text(
                          'norslt'.tr(),
                          style: const TextStyle(fontSize: 24),
                        ),
                ),

                SizedBox(height: heightSize(30)),
              ],
            );
          }),
        ));
  }
}
