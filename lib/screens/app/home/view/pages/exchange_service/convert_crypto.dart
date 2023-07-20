import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/screens/app/home/controller/changenow_controller.dart';
import 'package:binance_cl/shared/action_button.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/shared/custom_textfield.dart';
import 'package:binance_cl/shared/keyboard.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart' hide Trans;

class ConvertCrypto extends StatefulWidget {
  const ConvertCrypto({super.key});

  @override
  State<ConvertCrypto> createState() => _ConvertCryptoState();
}

class _ConvertCryptoState extends State<ConvertCrypto> {
  ChangeNowController changeNowController = Get.find();

  _onKeyboardTap(String value) {
    setState(() {
      changeNowController.fromAmountController.text =
          changeNowController.fromAmountController.text + value;
      changeNowController.fromAmount.value =
          changeNowController.fromAmount.value + value;
    });
    changeNowController.getEstimatedExchangeAmount();
  }

  @override
  void dispose() {
    super.dispose();
    changeNowController.fromAmount.value = "";
    changeNowController.fromAmountController.clear();
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
                  const CText(
                    text: "Convert",
                    color: kWhiteColor,
                    size: 30,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: heightSize(20)),
                  Container(
                    height: heightSize(250),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: kContainerColor,
                      borderRadius: BorderRadius.circular(Values().boxRadius2),
                    ),
                    child: Column(
                      children: [
                        Container(
                          // height: heightSize(30),
                          // width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: kWhiteColor.withOpacity(0.04),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(Values().boxRadius2),
                              bottomLeft: Radius.circular(Values().boxRadius2),
                            ),
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: '• ',
                              style: TextStyle(
                                fontSize: fontSize(14),
                                color: kPrimaryColor,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Available: ',
                                  style: TextStyle(
                                    fontSize: fontSize(14),
                                    color: kTextColor,
                                  ),
                                ),
                                TextSpan(
                                  text: '0.0',
                                  style: TextStyle(
                                    fontSize: fontSize(14),
                                    color: kTextColor,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' ${changeNowController.fromAssetCurrency.value.ticker!.toUpperCase()}',
                                  style: TextStyle(
                                    fontSize: fontSize(12),
                                    color: kText2Color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: heightSize(17)),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: kGreyColor.withOpacity(0.1),
                              child: SvgPicture.network(
                                changeNowController
                                    .fromAssetCurrency.value.image!,
                                height: heightSize(30),
                              ),
                            ),
                            SizedBox(width: widthSize(16)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CText(
                                  text: "From",
                                  size: 12,
                                  color: kText2Color,
                                ),
                                SizedBox(height: heightSize(5)),
                                CText(
                                  text: changeNowController
                                      .fromAssetCurrency.value.ticker!
                                      .toUpperCase(),
                                  size: 20,
                                  color: kTextColor,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: kText2Color),
                              ),
                              child: const CText(
                                text: "MAX",
                                color: kPrimaryColor,
                                size: 14,
                              ),
                            ),
                            SizedBox(width: widthSize(16)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const CText(
                                  text: "Amount",
                                  size: 12,
                                  color: kText2Color,
                                ),
                                SizedBox(height: heightSize(5)),
                                SizedBox(
                                  width: widthSize(70),
                                  height: heightSize(40),
                                  child: AuthTextField(
                                    enabled: false,
                                    color: kGreyColor.withOpacity(0.1),
                                    hint: "0.0",
                                    // hintColor: kGreyColor.withOpacity(0.5),
                                    controller: changeNowController
                                        .fromAmountController,
                                    error: changeNowController.error.value,
                                    inputType: TextInputType.number,
                                    validFunction: (v) => v!,
                                    onSavedFunction: (s) => {
                                      if (s.isNotEmpty)
                                        {
                                          changeNowController.error.value = '',
                                          changeNowController.fromAmount.value =
                                              s,
                                          changeNowController
                                              .getEstimatedExchangeAmount(),
                                          //print(email);
                                        }
                                      else
                                        {
                                          changeNowController.error.value =
                                              "eg: example@email.com",
                                          changeNowController.fromAmount.value =
                                              '0.00',
                                          changeNowController
                                              .getEstimatedExchangeAmount(),
                                        }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: heightSize(10)),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CText(
                            text:
                                "Minimum amount convertable: ${changeNowController.minAmount} ${changeNowController.fromAssetCurrency.value.ticker!.toUpperCase()}",
                            size: 12,
                          ),
                        ),
                        SizedBox(height: heightSize(17)),
                        Row(
                          children: [
                            const Expanded(child: Divider(thickness: 2)),
                            SizedBox(width: widthSize(16)),
                            const Icon(Feather.refresh_ccw,
                                color: kPrimaryColor),
                            SizedBox(width: widthSize(16)),
                            const Expanded(child: Divider(thickness: 2)),
                          ],
                        ),
                        SizedBox(height: heightSize(17)),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: kGreyColor.withOpacity(0.1),
                              child: SvgPicture.network(
                                changeNowController
                                    .toAssetCurrency.value.image!,
                                height: heightSize(30),
                              ),
                            ),
                            SizedBox(width: widthSize(16)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CText(
                                  text: "To",
                                  size: 12,
                                  color: kText2Color,
                                ),
                                SizedBox(height: heightSize(5)),
                                CText(
                                  text: changeNowController
                                      .toAssetCurrency.value.ticker!
                                      .toUpperCase(),
                                  size: 20,
                                  color: kTextColor,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const CText(
                                  text: "Amount",
                                  size: 12,
                                  color: kText2Color,
                                ),
                                SizedBox(height: heightSize(5)),
                                Obx(
                                  () => CText(
                                    text: changeNowController.toAmount.value,
                                    size: 20,
                                    color: kTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  NumericKeyboard(
                    onKeyboardTap: _onKeyboardTap,
                    textColor: kText2Color,
                    leftButtonFn: () {
                      setState(() {
                        // controller.text = controller.text
                        //     .substring(0, controller.text.length - 1);
                        if (changeNowController.fromAmount.value.isNotEmpty) {
                          changeNowController.fromAmount.value =
                              changeNowController.fromAmount.value.substring(
                                  0,
                                  changeNowController.fromAmount.value.length -
                                      1);

                          changeNowController.fromAmountController.text =
                              changeNowController.fromAmountController.text
                                  .substring(
                                      0,
                                      changeNowController.fromAmountController
                                              .text.length -
                                          1);
                          changeNowController.getEstimatedExchangeAmount();

                          setState(() {});
                        }
                      });
                    },
                    leftIcon: const Icon(
                      Entypo.chevron_with_circle_left,
                      color: kBlackColor,
                    ),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  SizedBox(height: heightSize(40)),
                  ActionButton(
                    text: "Exchange",
                    callback: () {},
                    color: kPrimaryColor.withOpacity(0.1),
                    textColor: kPrimaryColor,
                  ),
                  SizedBox(height: heightSize(40)),
                ],
              );
            }),
          ),
        ));
  }
}
