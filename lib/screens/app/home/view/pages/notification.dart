import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNotifications extends StatefulWidget {
  const AppNotifications({super.key});

  @override
  State<AppNotifications> createState() => _AppNotificationsState();
}

class _AppNotificationsState extends State<AppNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: constraints.maxHeight * 0.01),
                Row(
                  children: [
                    const CText(
                      text: "Notifications",
                      color: kTextColor,
                      size: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        color: kText2Color,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: heightSize(20)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Align(
                        child: CText(
                          text: "You have no notification at the moment ...",
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
