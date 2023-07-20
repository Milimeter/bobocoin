import 'package:binance_cl/screens/app/wallets/controller/balance_controller.dart';
import 'package:binance_cl/screens/app/wallets/view/pages/overview/modals/complete_withdrawal.dart';
import 'package:binance_cl/shared/action_button.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/shared/custom_toast.dart';
import 'package:binance_cl/shared/keyboard.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:binance_cl/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class WithdrawalAmountInput extends StatefulWidget {
  const WithdrawalAmountInput({super.key});

  @override
  State<WithdrawalAmountInput> createState() => _WithdrawalAmountInputState();
}

class _WithdrawalAmountInputState extends State<WithdrawalAmountInput> {
  BalanceController balanceController = Get.find();
  TextEditingController controller = TextEditingController();

  String symbol = "";
  String name = "";
  String amount = '0.00';
  _onKeyboardTap(String value) {
    setState(() {
      controller.text = controller.text + value;
      amount = amount + value;
    });
  }

  @override
  void initState() {
    super.initState();
    symbol = Get.arguments["symbol"];
    name = Get.arguments["name"];
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
                  text: "Withdraw",
                  color: kWhiteColor,
                  size: 30,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: heightSize(20)),
                Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: CText(
                          text: symbol,
                          color: kText2Color,
                          size: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: widthSize(10)),
                      CText(
                        text: amount,
                        color: kTextColor,
                        size: 60,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: heightSize(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CText(
                      text: "AVAILABLE BALANCE: ",
                      color: kText2Color,
                      size: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    CText(
                      text: balanceController.balances[symbol.toUpperCase()],
                      color: kPrimaryColor,
                      size: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                Align(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        amount =
                            balanceController.balances[symbol.toUpperCase()];
                      });
                    },
                    child: const CText(
                      text: "MAX",
                      color: kPrimaryColor,
                      size: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
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
                      if (amount.isNotEmpty) {
                        amount = amount.substring(0, amount.length - 1);
                      }
                    });
                  },
                  leftIcon: const Icon(
                    Entypo.chevron_with_circle_left,
                    color: kText2Color,
                  ),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                SizedBox(height: heightSize(40)),
                ActionButton(
                  text: "Continue",
                  callback: () {
                    if (amount == '0.00' || amount.isEmpty) {
                      cToast(title: "Notice", message: "Invalid Amount");
                    } else {
                      modalSetup(
                        context,
                        modalPercentageHeight: 0.6,
                        createPage: CompleteWithdrawal(
                          name: name,
                          symbol: symbol,
                          amount: amount,
                        ),
                        showBarrierColor: true,
                      );
                    }
                  },
                  color: amount == '0.00' || amount.isEmpty
                      ? kPrimaryColor.withOpacity(0.1)
                      : kPrimaryColor,
                  textColor: amount == '0.00' || amount.isEmpty
                      ? kPrimaryColor
                      : kWhiteColor,
                ),
                SizedBox(height: heightSize(40)),
              ],
            );
          }),
        ),
      ),
    );
  }
}
