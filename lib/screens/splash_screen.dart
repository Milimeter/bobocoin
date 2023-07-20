import 'package:binance_cl/constants/assets_path.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          // Positioned.fill(
          //   child: Align(
          //     alignment: Alignment.bottomCenter,
          //     child: SpinKitWave(
          //       color: kPrimaryColor,
          //       size: 50.0,
          //     ),
          //   ),
          // ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(logo, width: widthSize(60)),
                  SizedBox(height: heightSize(10)),
                  const CText(
                    text: "BOBOCOIN",
                    color: kPrimaryColor,
                    size: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
