import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/screens/app/wallets/view/components/transfer_asset_picker.dart';
import 'package:binance_cl/screens/app/wallets/view/components/transfer_switcher.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class InternalTransfer extends StatelessWidget {
  const InternalTransfer({Key? key}) : super(key: key);

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
                  SizedBox(height: constraints.maxHeight * 0.03),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      color: kText2Color,
                    ),
                  ),
                  SizedBox(height: heightSize(30)),
                   CText(
                    text: "tnsf".tr(),
                    color: kWhiteColor,
                    size: 30,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: heightSize(40)),
                  const TransferSwitcher(),
                  SizedBox(height: heightSize(20)),
                  const TransferAssetPicker(),
                  SizedBox(height: heightSize(40)),
                   CText(
                    text: "tramt".tr(),
                    color: kText2Color,
                    size: 18,
                  ),
                  SizedBox(height: heightSize(10)),
                  Container(
                    height: heightSize(50),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: kContainerColor,
                      borderRadius: BorderRadius.circular(Values().boxRadius2),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              showCursor: true,
                              cursorColor: kTextColor,
                              keyboardType: TextInputType.number,
                              //validator: validator,
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: fontSize(14),
                              ),
                              decoration: InputDecoration(
                                hintText:
                                    "trinfo".tr(),
                                hintStyle: TextStyle(
                                  color: kText2Color,
                                  fontSize: fontSize(14),
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          const CText(
                            text: "BTC",
                            color: kTextColor,
                            size: 18,
                          ),
                          SizedBox(width: widthSize(10)),
                          const CText(
                            text: "All",
                            color: kPrimaryColor,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: heightSize(10)),
                  Row(
                    children: [
                       CText(
                        text: "tramtinfo".tr(),
                        color: kText2Color,
                        size: 14,
                      ),
                      SizedBox(width: widthSize(5)),
                      const CText(
                        text: "0 BTC",
                        color: kTextColor,
                        size: 14,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: heightSize(50),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kContainerColor,
                      borderRadius: BorderRadius.circular(Values().boxRadius2),
                      //border: Border.all(color: kPrimaryColor),
                    ),
                    child:  Center(
                      child: CText(
                        text: "cnftrf".tr(),
                        color: kBackgroundColor,
                        size: 17,
                      ),
                    ),
                  ),
                  SizedBox(height: heightSize(30)),
                ],
              );
            }),
          ),
        ));
  }
}
