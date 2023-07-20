import 'dart:async';

import 'package:binance_cl/constants/assets_path.dart';
import 'package:binance_cl/main.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Language extends StatelessWidget {
  const Language({Key? key}) : super(key: key);

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
                  SizedBox(height: constraints.maxHeight * 0.05),
                  // const Align(
                  // child: CText(
                  //   text: "BOBOCOIN",
                  //   color: kPrimaryColor,
                  //   size: 30,
                  //   fontWeight: FontWeight.w700,
                  // ),
                  // ),
                  Image.asset(
                    translate,
                    height: heightSize(100),
                  ),
                  SizedBox(height: heightSize(60)),
                  const CText(
                    text: "Choose your Preferred Language",
                    color: kPrimaryColor,
                    size: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: heightSize(10)),
                  const CText(
                    text: "Please select your language",
                    size: 18,
                    color: kText2Color,
                  ),
                  SizedBox(height: heightSize(30)),
                  // language(
                  //   countryString: "🇭🇰",
                  //   countryLanguage: "Cantonese",
                  //   isSelected: false,
                  //   callback: () {
                  //     context.setLocale(const Locale('yue'));
                  //     Timer(const Duration(seconds: 1), () {
                  //       RestartWidget.restartApp(context);
                  //     });
                  //   },
                  // ),
                  language(
                    countryString: "🇬🇧",
                    countryLanguage: "English",
                    isSelected: context.locale.toString() == "en",
                    callback: () {
                      context.setLocale(const Locale('en'));
                      Timer(const Duration(seconds: 1), () {
                        RestartWidget.restartApp(context);
                      });
                    },
                  ),
                  // language(
                  //   countryString: "🇯🇵",
                  //   countryLanguage: "Japanese",
                  //   isSelected: false,
                  //   callback: () {
                  //     context.setLocale(const Locale('ja'));
                  //     Timer(const Duration(seconds: 1), () {
                  //       RestartWidget.restartApp(context);
                  //     });
                  //   },
                  // ),
                  language(
                    countryString: "🇨🇳",
                    countryLanguage: "Simplified Chinese",
                    isSelected: context.locale.toString() == "zh",
                    callback: () {
                      context.setLocale(const Locale('zh'));
                      Timer(const Duration(seconds: 1), () {
                        RestartWidget.restartApp(context);
                      });
                    },
                  ),
                ],
              );
            }),
          ),
        ));
  }

  Widget language({
    required String countryString,
    required String countryLanguage,
    required bool isSelected,
    required VoidCallback callback,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: kText2Color,
                  child: CText(text: countryString, size: 30),
                ),
                SizedBox(width: widthSize(20)),
                CText(
                  text: countryLanguage,
                  size: 20,
                ),
                const Spacer(),
                isSelected == true
                    ? const Icon(
                        Entypo.check,
                        color: kPrimaryColor,
                        size: 30,
                      )
                    : const Offstage()
              ],
            ),
            SizedBox(height: heightSize(15)),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
