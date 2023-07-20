import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/screens/app/home/view/modals/select_exchange.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:binance_cl/utils/utilities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class P2PContainer extends StatelessWidget {
  const P2PContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              showHelpSnackBar(
                  context: context,
                  title: "Oh Snap!",
                  messages: "Content not available at the moment.");
            },
            child: Container(
              height: heightSize(120),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: kContainerColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Values().boxRadius),
                  bottomRight: Radius.circular(Values().boxRadius),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   CText(
                    text: "deptyen".tr(),
                    size: 20,
                    fontFamily: "Poppins-SemiBold",
                  ),
                  SizedBox(height: heightSize(2)),
                   CText(
                    text: "bnktr".tr(),
                    size: 12,
                    color: kText2Color,
                  ),
                  const Spacer(),
                  Row(children: [
                    const Icon(
                      Entypo.credit_card,
                      color: kPrimaryColor,
                      size: 35,
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: kGreyColor.withOpacity(0.3),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: kBackgroundColor,
                        size: 15,
                      ),
                    ),
                  ])
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: widthSize(10)),
        Expanded(
          child: GestureDetector(
            onTap: () {
              // showHelpSnackBar(
              //     context: context,
              //     title: "Oh Snap!",
              //     messages: "Content not available at the moment.");
              modalSetup(
                context,
                modalPercentageHeight: 0.5,
                createPage: const SelectExchangeType(),
                showBarrierColor: true,
              );
            },
            child: Container(
              height: heightSize(120),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: kContainerColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Values().boxRadius),
                  bottomLeft: Radius.circular(Values().boxRadius),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   CText(
                    text: "exchserv".tr(),
                    size: 20,
                    fontFamily: "Poppins-SemiBold",
                  ),
                  SizedBox(height: heightSize(2)),
                   CText(
                    text: "exchinfo".tr(),
                    size: 12,
                    color: kText2Color,
                  ),
                  const Spacer(),
                  Row(children: [
                    const Icon(
                      FontAwesome.users,
                      color: kPrimaryColor,
                      size: 25,
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: kGreyColor.withOpacity(0.3),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: kBackgroundColor,
                        size: 15,
                      ),
                    ),
                  ])
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
