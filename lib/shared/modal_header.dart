import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';

class ModalHeader extends StatelessWidget {
  final VoidCallback backCallback;
  final VoidCallback closeCallback;
  final String title;
  final bool? showIcons;
  final Color? iconColor;
  final Color? textColor;
  final bool? showBackButton;
  final bool? showCloseButton;
  const ModalHeader({
    Key? key,
    required this.backCallback,
    required this.closeCallback,
    required this.title,
    this.showIcons = true,
    this.iconColor,
    this.textColor,
    this.showBackButton = true,
    this.showCloseButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        showIcons == false
            ? const SizedBox(height: 10)
            : showBackButton == false
                ? const SizedBox(height: 10, width: 35)
                : IconButton(
                    onPressed: backCallback,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: iconColor ?? kWhiteColor,
                      size: 25,
                    ),
                  ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CText(
            text: title,
            fontWeight: FontWeight.w500,
            size: 20,
            color: textColor ?? kWhiteColor,
            fontFamily: "Poppins-SemiBold",
          ),
        ),
        showIcons == false
            ? const SizedBox(height: 1)
            : showCloseButton == false
                ? const SizedBox(height: 10, width: 35)
                : IconButton(
                    onPressed: closeCallback,
                    icon: Icon(
                      Feather.x_circle,
                      color: iconColor ?? kWhiteColor,
                      size: 30,
                    ),
                  ),
      ],
    );
  }
}
