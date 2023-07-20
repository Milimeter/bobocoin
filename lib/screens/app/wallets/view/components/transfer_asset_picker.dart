import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';

class TransferAssetPicker extends StatelessWidget {
  const TransferAssetPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightSize(50),
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: kContainerColor,
        borderRadius: BorderRadius.circular(Values().boxRadius2),
      ),
      child: Row(
        children: [
          const CText(
            text: "Coin",
            color: kText2Color,
            size: 14,
          ),
          const Spacer(),
          const CText(
            text: "BTC",
            color: kTextColor,
            size: 18,
          ),
          SizedBox(width: widthSize(5)),
          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: kTextColor,
          )
        ],
      ),
    );
  }
}
