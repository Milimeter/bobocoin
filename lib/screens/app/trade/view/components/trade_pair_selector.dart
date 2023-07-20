import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class TradePairSelector extends StatefulWidget {
  const TradePairSelector({Key? key}) : super(key: key);

  @override
  State<TradePairSelector> createState() => _TradePairSelectorState();
}

class _TradePairSelectorState extends State<TradePairSelector> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightSize(125),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Entypo.list,
                color: kWhiteColor,
              ),
              SizedBox(width: widthSize(10)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CText(
                    text: "BTC/USDT",
                    color: kTextColor,
                    size: 25,
                    height: 1.25,
                  ),
                  CText(
                    text: "Long BTC (3x Leverage)",
                    color: kText2Color,
                    size: 14,
                  ),
                ],
              ),
              SizedBox(width: widthSize(20)),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xFFFF3B30).withOpacity(0.1),
                ),
                child: const CText(
                  text: "-2.74%",
                  color: Color(0xFFFF3B30),
                  size: 11,
                ),
              ),
              const Spacer(),
              const Icon(
                Feather.activity,
                color: kWhiteColor,
              ),
              SizedBox(width: widthSize(20)),
              const Icon(
                Octicons.kebab_horizontal,
                color: kWhiteColor,
              ),
            ],
          ),
          const Spacer(),
          const Divider(),
          SizedBox(height: heightSize(8)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CText(
                    text: "Actual Leverage",
                    color: kTextColor,
                    size: 13,
                  ),
                  SizedBox(height: heightSize(6)),
                  const CText(
                    text: "2.7272x",
                    color: kPrimaryColor,
                    size: 14,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CText(
                    text: "Net Asset Value",
                    color: kTextColor,
                    size: 13,
                  ),
                  SizedBox(height: heightSize(6)),
                  const CText(
                    text: "2.7272x",
                    color: kText2Color,
                    size: 14,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CText(
                    text: "Daily Management Fee(0%)",
                    color: kTextColor,
                    size: 13,
                  ),
                  SizedBox(height: heightSize(6)),
                  const CText(
                    text: "0%",
                    color: kPrimaryColor,
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: heightSize(8)),
          const Divider()
        ],
      ),
    );
  }
}
