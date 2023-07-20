import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/shared/action_button.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:binance_cl/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteWithdrawal extends StatefulWidget {
  final String name;
  final String symbol;
  final String amount;
  const CompleteWithdrawal(
      {super.key,
      required this.name,
      required this.symbol,
      required this.amount});

  @override
  State<CompleteWithdrawal> createState() => _CompleteWithdrawalState();
}

class _CompleteWithdrawalState extends State<CompleteWithdrawal> {
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
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
                SizedBox(height: heightSize(5)),
                CText(
                  text: "Withdraw ${widget.symbol} to crypto address",
                  color: kText2Color,
                  size: 15,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: heightSize(20)),
                const CText(
                  text: "Wallet Address",
                  color: kPrimaryColor,
                  size: 15,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: heightSize(10)),
                Container(
                  height: heightSize(55),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kContainerColor,
                    borderRadius: BorderRadius.circular(Values().boxRadius2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: TextFormField(
                        controller: addressController,
                        showCursor: true,
                        cursorColor: kTextColor,
                        //validator: validator,
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: fontSize(14),
                        ),
                        decoration: InputDecoration(
                          hintText: "Long press to paste",
                          hintStyle: TextStyle(
                            color: kText2Color,
                            fontSize: fontSize(14),
                          ),

                          // hintStyle: GoogleFonts.sansita(
                          //   color: kWhite,
                          // ),

                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: heightSize(20)),
                const CText(
                  text:
                      "Note:\nDo not withdraw directly to a crowdfund or ICO.  We will not credit your account with tokens from that sale.",
                  color: kText2Color,
                  size: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
                const CText(
                  text:
                      "Please make sure that your withdrawal address is correct. Otherwise, your withdrawan funds will be lost - nor will it be refunded.",
                  color: kText2Color,
                  size: 15,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
                const Spacer(),
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CText(
                            text: "Receive amount",
                            color: kText2Color,
                            size: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          CText(
                            text:
                                "${formatMoney(widget.amount)} ${widget.symbol}",
                            color: kTextColor,
                            size: 25,
                            fontWeight: FontWeight.w500,
                          ),
                          const CText(
                            text: "Network fee: Automatically generated",
                            color: kText2Color,
                            size: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ]),
                    SizedBox(width: widthSize(20)),
                    Expanded(
                      child: ActionButton(
                        text: "Withdraw",
                        callback: () {},
                        color: addressController.text.isEmpty
                            ? kPrimaryColor.withOpacity(0.1)
                            : kPrimaryColor,
                        textColor: addressController.text.isEmpty
                            ? kPrimaryColor
                            : kWhiteColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: heightSize(10)),
              ],
            );
          }),
        ),
      ),
    );
  }
}
