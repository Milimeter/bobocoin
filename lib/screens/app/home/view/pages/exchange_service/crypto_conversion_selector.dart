// ignore_for_file: invalid_use_of_protected_member

import 'package:anim_search_app_bar/anim_search_app_bar.dart';
import 'package:binance_cl/models/binance/changenow/available_currencies.dart';
import 'package:binance_cl/screens/app/home/controller/changenow_controller.dart';
import 'package:binance_cl/shared/action_button.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;

class CryptoToCryptoSelector extends StatefulWidget {
  const CryptoToCryptoSelector({Key? key}) : super(key: key);

  @override
  State<CryptoToCryptoSelector> createState() => _CryptoToCryptoSelectorState();
}

class _CryptoToCryptoSelectorState extends State<CryptoToCryptoSelector> {
  TextEditingController textEditingController = TextEditingController();
  ChangeNowController changeNowController = Get.find();

  List<ChangeNowAvailableCurrencies> filteredCurrencyList = [];
  String fromAsset = "";
  String toAsset = "";
  bool canContinue = false;

  @override
  void initState() {
    filteredCurrencyList =
        List.from(changeNowController.changeNowAvailableCurrencies.value);
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<ChangeNowAvailableCurrencies> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = changeNowController.changeNowAvailableCurrencies.value;
    } else {
      results = changeNowController.changeNowAvailableCurrencies.value
          .where((currency) =>
              currency.name!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              currency.ticker!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      filteredCurrencyList = results;
    });
  }

  resetSelection() {
    toAsset = "";
    fromAsset = "";
    canContinue = false;
    textEditingController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                Column(
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
                        title: const CText(
                          text: "Please search your preferred asset to convert",
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
                      cancelButtonText: "Cancel",
                      hintText: 'Search',
                    ),
                    SizedBox(height: heightSize(20)),
                    Expanded(
                      child: filteredCurrencyList.isNotEmpty
                          ? ListView.builder(
                              itemCount: filteredCurrencyList.length,
                              itemBuilder: (context, index) {
                                bool isSelected = filteredCurrencyList[index]
                                                .ticker! ==
                                            fromAsset ||
                                        filteredCurrencyList[index].ticker! ==
                                            toAsset
                                    ? true
                                    : false;
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 28),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (fromAsset.isEmpty) {
                                        //select first asset
                                        fromAsset =
                                            filteredCurrencyList[index].ticker!;
                                        setState(() {});
                                      } else {
                                        // select second asset
                                        toAsset =
                                            filteredCurrencyList[index].ticker!;
                                        setState(() {});
                                      }
                                      if (toAsset.isNotEmpty &&
                                          fromAsset.isNotEmpty) {
                                        canContinue = true;
                                        setState(() {});
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 16,
                                          backgroundColor:
                                              kGreyColor.withOpacity(0.1),
                                          child: SvgPicture.network(
                                              filteredCurrencyList[index]
                                                  .image!),
                                        ),
                                        SizedBox(width: widthSize(16)),
                                        CText(
                                          text: filteredCurrencyList[index]
                                              .ticker!
                                              .toUpperCase(),
                                          size: 18,
                                          fontFamily: "Poppins-SemiBold",
                                        ),
                                        SizedBox(width: widthSize(6)),
                                        CText(
                                          text:
                                              filteredCurrencyList[index].name!,
                                          size: 14,
                                          color: isSelected
                                              ? kPrimaryColor
                                              : kText2Color,
                                        ),
                                        const Spacer(),
                                        fromAsset ==
                                                filteredCurrencyList[index]
                                                    .ticker!
                                            ? CText(
                                                text:
                                                    "convert from ${filteredCurrencyList[index].ticker!.toUpperCase()}",
                                                size: 12,
                                                color: kPrimaryColor,
                                              )
                                            : const SizedBox.shrink(),
                                        toAsset ==
                                                filteredCurrencyList[index]
                                                    .ticker!
                                            ? CText(
                                                text:
                                                    "to ${filteredCurrencyList[index].ticker!.toUpperCase()}",
                                                size: 12,
                                                color: kPrimaryColor,
                                              )
                                            : const SizedBox.shrink(),
                                        SizedBox(width: widthSize(8)),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : Center(
                              child: Text(
                                'No results found',
                                style: TextStyle(fontSize: fontSize(24)),
                              ),
                            ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.back();
                    //   },
                    //   child: const Icon(
                    //     Icons.close,
                    //     color: kText2Color,
                    //   ),
                    // ),
                    // SizedBox(height: heightSize(30)),
                    // const CText(
                    //   text: "Transfer",
                    //   color: kWhiteColor,
                    //   size: 30,
                    //   fontWeight: FontWeight.w700,
                    // ),

                    SizedBox(height: heightSize(30)),
                  ],
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: SizedBox(
                              height: heightSize(72),
                              child: ActionButton(
                                text: "Continue",
                                callback: () {
                                  if (canContinue) {
                                    changeNowController.fromAsset.value =
                                        fromAsset;
                                    changeNowController.toAsset.value = toAsset;
                                    changeNowController
                                        .getMinimumExchangeAmount(context);
                                    // Get.toNamed(
                                    //     Routes.CRYPTO_TO_CRYPTO_CONVERTER);
                                  }
                                },
                                color: canContinue
                                    ? kPrimaryColor
                                    : kPrimaryColor.withOpacity(0.1),
                                textColor:
                                    canContinue ? kWhiteColor : kPrimaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: widthSize(20)),
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: heightSize(72),
                              child: ActionButton(
                                text: "Reset",
                                callback: () {
                                  resetSelection();
                                },
                                color: kBlackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
