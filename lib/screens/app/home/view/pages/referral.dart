import 'package:binance_cl/constants/assets_path.dart';
import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart' hide Trans;

class Referral extends StatefulWidget {
  const Referral({Key? key}) : super(key: key);

  @override
  State<Referral> createState() => _ReferralState();
}

class _ReferralState extends State<Referral> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
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
                    text: "Invite Friends and Earn \nCashback!",
                    color: kWhiteColor,
                    size: 30,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                  SizedBox(height: heightSize(40)),
                  const CText(
                    text:
                        "Refer your friend to earn bonuses in your wallet. Earn up to 30% commission for each friday you refer to our Copy Trading platform.",
                    color: kWhiteColor,
                    size: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                  SizedBox(height: heightSize(20)),
                  Container(
                    height: heightSize(200),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 6),
                    margin: const EdgeInsets.symmetric(horizontal: 18.0),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(Values().boxRadius2),
                      border: Border.all(color: kPrimaryColor, width: 1.5),
                    ),
                    child: Center(
                      child: SvgPicture.asset(referral),
                    ),
                  ),
                  SizedBox(height: heightSize(50)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      sites(
                        icon: FontAwesome.facebook,
                        iconColor: kPrimaryColor,
                        callback: () {},
                      ),
                      sites(
                        icon: FontAwesome.twitter,
                        iconColor: kPrimaryColor,
                        callback: () {},
                      ),
                      sites(
                        icon: FontAwesome.instagram,
                        iconColor: kPrimaryColor,
                        callback: () {},
                      ),
                      sites(
                        icon: FontAwesome.whatsapp,
                        iconColor: kPrimaryColor,
                        callback: () {},
                      ),
                      sites(
                        icon: FontAwesome.telegram,
                        iconColor: kPrimaryColor,
                        callback: () {},
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget sites(
      {required IconData icon,
      required Color iconColor,
      required VoidCallback callback}) {
    return GestureDetector(
      onTap: callback,
      child: CircleAvatar(
          radius: 25,
          backgroundColor: kPrimaryColor.withOpacity(0.1),
          child: Icon(icon, color: iconColor)),
    );
  }
}
