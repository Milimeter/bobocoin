import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final Color? color;
  final Color? textColor;
  final bool? load;
  final double? height;
  final FontWeight? fontWeight;

  const ActionButton({
    Key? key,
    required this.text,
    required this.callback,
    this.color,
    this.textColor,
    this.load = false,
    this.fontWeight,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: heightSize(height ?? 55),
        width: size.width,
        decoration: BoxDecoration(
            color: color ?? kPrimaryColor,
            borderRadius: BorderRadius.circular(Values().boxRadius2)),
        child: Center(
          child: load == true
              ? const SpinKitDoubleBounce(
                  color: kWhiteColor,
                  size: 45,
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: CText(
                    text: text,
                    fontWeight: fontWeight ?? FontWeight.w400,
                    size: 18,
                    color: textColor ?? kWhiteColor,
                    textAlign: TextAlign.center,
                    // letterSpacing: 2,
                  ),
                ),
        ),
      ),
    );
  }
}
