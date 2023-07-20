import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/screens/app/trade/controller/trade_controller.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart' hide Trans;

class BuildLeftColumn extends StatefulWidget {
  const BuildLeftColumn({Key? key}) : super(key: key);

  @override
  State<BuildLeftColumn> createState() => _BuildLeftColumnState();
}

class _BuildLeftColumnState extends State<BuildLeftColumn> {
  TradeController tradeController = Get.find();
  // List<String> orderType = [
  //   "LIMIT",
  //   "LIMIT_MAKER",
  //   "MARKET",
  //   "STOP_LOSS_LIMIT",
  //   "TAKE_PROFIT_LIMIT"
  // ]; // Option 1
  List<String> orderType = [
    "MARKET",
  ]; // Option 1
  String selectedOrderType = 'MARKET';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: heightSize(40),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Values().boxRadius2),
          ),
          child: Obx(
            () => Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      tradeController.selectBuyTab();
                    },
                    child: Container(
                      height: heightSize(40),
                      decoration: BoxDecoration(
                        color: tradeController.isBuySelected.value
                            ? kUptrendColor
                            : kGreyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Values().boxRadius2),
                          bottomLeft: Radius.circular(Values().boxRadius2),
                          bottomRight: Radius.circular(Values().boxRadius2),
                        ),
                      ),
                      child: Center(
                        child: CText(
                          text: "buy".tr(),
                          color: tradeController.isBuySelected.value
                              ? kWhiteColor
                              : kText2Color,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: widthSize(10)),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      tradeController.selectSellTab();
                    },
                    child: Container(
                      height: heightSize(40),
                      decoration: BoxDecoration(
                        color: tradeController.isSellSelected.value
                            ? const Color(0xFFFF3232)
                            : kGreyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Values().boxRadius2),
                          topRight: Radius.circular(Values().boxRadius2),
                          bottomRight: Radius.circular(Values().boxRadius2),
                        ),
                      ),
                      child: Center(
                        child: CText(
                          text: "sell".tr(),
                          color: tradeController.isSellSelected.value
                              ? kWhiteColor
                              : kText2Color,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: heightSize(10)),
        Container(
          padding: const EdgeInsets.fromLTRB(6.0, 0.0, 4.0, 0.0),
          decoration: BoxDecoration(
            color: kGreyColor.withOpacity(0.2),
            border: Border.all(
              color: kGreyColor.withOpacity(0.2),
              width: .5,
            ),
            borderRadius: BorderRadius.circular(Values().boxRadius2),
          ),
          child: DropdownButton(
            underline: const SizedBox(),
            value: selectedOrderType,
            isExpanded: true,
            onChanged: (newValue) {
              setState(() {
                selectedOrderType = newValue.toString();
              });
            },
            icon: Obx(
              () => Icon(
                Entypo.chevron_down,
                color: tradeController.isBuySelected.value
                    ? kUptrendColor
                    : const Color(0xFFFF3232),
                size: 16,
              ),
            ),
            items: orderType.map(
              (type) {
                return DropdownMenuItem(
                  value: type,
                  child: CText(
                    text: type,
                    color: kTextColor,
                  ),
                );
              },
            ).toList(),
          ),
        ),
        SizedBox(height: heightSize(10)),
        Container(
          height: heightSize(50),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: kGreyColor.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(Values().boxRadius2),
          ),
          child: Obx(
            () => Center(
              child: CText(
                text:
                    "Amount (${tradeController.totalSourcePair.value == "0.00" ? tradeController.tradePair.value.substring(0, 3) : tradeController.totalSourcePair.value})",
              ),
            ),
          ),
        ),
        SizedBox(height: heightSize(10)),
        Container(
          height: heightSize(50),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: kGreyColor.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(Values().boxRadius2),
          ),
          child: Obx(
            () => Center(
              child: CText(
                text:
                    "Total ( ${tradeController.totalBasePair.value == "0.00" ? tradeController.balance.value.asset ?? "USDT" : tradeController.totalBasePair.value})", //balance
              ),
            ),
          ),
        ),
        SizedBox(height: heightSize(10)),
        Row(
          children: [
            CText(
              text: "Avlb: ",
              color: kGreyColor.withOpacity(0.8),
              size: 14,
            ),
            Obx(
              () => CText(
                text:
                    "${double.parse(tradeController.balance.value.free ?? "0.00").toStringAsFixed(2)} ${tradeController.balance.value.asset ?? "USDT"}",
                color: tradeController.isBuySelected.value
                    ? kUptrendColor
                    : const Color(0xFFFF3232),
              ),
            ),
          ],
        ),
        SizedBox(height: heightSize(10)),
        Container(
          height: heightSize(40),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Values().boxRadius2),
            border: Border.all(color: kBlackColor, width: 1),
          ),
          child: Obx(
            () => Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      tradeController.select25PercentTab();
                    },
                    child: Container(
                      height: heightSize(40),
                      decoration: BoxDecoration(
                        color: tradeController.is25PercentSelected.value
                            ? kBlackColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Values().boxRadius2),
                          bottomLeft: Radius.circular(Values().boxRadius2),
                        ),
                      ),
                      child: Center(
                        child: CText(
                          text: "25%",
                          color: tradeController.is25PercentSelected.value
                              ? kWhiteColor
                              : kBlackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      tradeController.select50PercentTab();
                    },
                    child: Container(
                      height: heightSize(40),
                      decoration: BoxDecoration(
                        color: tradeController.is50PercentSelected.value
                            ? kBlackColor
                            : Colors.transparent,
                        border: const Border.symmetric(
                          vertical: BorderSide(color: kBlackColor),
                        ),
                      ),
                      child: Center(
                        child: CText(
                          text: "50%",
                          color: tradeController.is50PercentSelected.value
                              ? kWhiteColor
                              : kBlackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      tradeController.select75PercentTab();
                    },
                    child: Container(
                      height: heightSize(40),
                      decoration: BoxDecoration(
                        color: tradeController.is75PercentSelected.value
                            ? kBlackColor
                            : Colors.transparent,
                        border: const Border.symmetric(
                          vertical: BorderSide(color: kBlackColor),
                        ),
                      ),
                      child: Center(
                        child: CText(
                          text: "75%",
                          color: tradeController.is75PercentSelected.value
                              ? kWhiteColor
                              : kBlackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      tradeController.select100PercentTab();
                    },
                    child: Container(
                      height: heightSize(40),
                      decoration: BoxDecoration(
                        color: tradeController.is100PercentSelected.value
                            ? kBlackColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Values().boxRadius2),
                          bottomRight: Radius.circular(Values().boxRadius2),
                        ),
                      ),
                      child: Center(
                        child: CText(
                          text: "100%",
                          color: tradeController.is100PercentSelected.value
                              ? kWhiteColor
                              : kBlackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: heightSize(10)),
        Align(
          alignment: Alignment.centerLeft,
          child: CText(
            text: "tkrfee".tr(),
            color: kGreyColor.withOpacity(0.8),
            size: 14,
          ),
        ),
        SizedBox(height: heightSize(3)),
        Align(
          alignment: Alignment.centerLeft,
          child: CText(
            text: "0.2% 0.00 USDT",
            color: kGreyColor.withOpacity(0.8),
            size: 14,
          ),
        ),
        SizedBox(height: heightSize(10)),
        Obx(
          () => GestureDetector(
            onTap: () {
              if (tradeController.load.value == false &&
                  tradeController.totalSourcePair.value != "Infinity") {
                tradeController.createSpotOrder();
              }
            },
            child: Container(
              height: heightSize(50),
              width: double.infinity,
              decoration: BoxDecoration(
                color: tradeController.isBuySelected.value
                    ? kUptrendColor
                    : const Color(0xFFFF3232),
                border: Border.all(
                  color: kGreyColor.withOpacity(0.2),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(Values().boxRadius2),
              ),
              child: Obx(
                () => Center(
                  child: tradeController.load.value == true
                      ? const SpinKitDoubleBounce(
                          color: kWhiteColor,
                          size: 45,
                        )
                      : CText(
                          text: tradeController.isBuySelected.value
                              ? "bymkt".tr()
                              : "selmkt".tr(),
                          color: kWhiteColor,
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
