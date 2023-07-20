import 'package:binance_cl/constants/assets_path.dart';
import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchContainer extends StatelessWidget {
  final double width;
  final double height;
  final String? assetName;
  final String? text;
  final Color? textColor;
  final Color? iconColor;
  final VoidCallback callback;
  final bool? addMargin;

  const SearchContainer({
    Key? key,
    required this.width,
    required this.height,
    this.assetName,
    required this.callback,
    this.text,
    this.addMargin = true,
    this.textColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
        decoration: BoxDecoration(
          color: kContainerColor,
          borderRadius: BorderRadius.circular(Values().buttonRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              assetName ?? lens,
              height: heightSize(25),
              width: widthSize(25),
              color: iconColor ?? kPrimaryColor,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CText(
                text: text ?? "Search Here",
                fontWeight: FontWeight.w400,
                size: 14,
                color: textColor ?? kGreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
