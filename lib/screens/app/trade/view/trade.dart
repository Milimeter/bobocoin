import 'package:binance_cl/screens/app/trade/view/components/spot_orders.dart';
import 'package:binance_cl/screens/app/trade/view/components/trade_pair_selector.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'components/build_left_column.dart';
import 'components/build_right_column.dart';

class TradeScreen extends StatelessWidget {
  const TradeScreen({Key? key}) : super(key: key);

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
                SizedBox(height: constraints.maxHeight * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: CText(
                    text: "trspt".tr(),
                    color: kTextColor,
                    size: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: heightSize(20)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: TradePairSelector(),
                ),
                SizedBox(height: heightSize(10)),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                                child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.0),
                              child: BuildLeftColumn(),
                            )),
                            SizedBox(width: widthSize(16)),
                            const Expanded(
                                child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.0),
                              child: BuildRightColumn(),
                            )),
                          ],
                        ),
                        Container(
                          height: heightSize(90),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.1),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Octicons.issue_opened,
                                color: kPrimaryColor,
                                size: 17,
                              ),
                              SizedBox(width: widthSize(8)),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            'tr1info'.tr(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: kText2Color,
                                          fontSize: fontSize(12),
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            'tr2info'.tr(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: kPrimaryColor,
                                          fontSize: fontSize(12),
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'tr3info'.tr(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: kText2Color,
                                          fontSize: fontSize(12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: heightSize(20)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: SpotOrders(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
