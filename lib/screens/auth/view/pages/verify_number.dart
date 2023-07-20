import 'package:binance_cl/constants/assets_path.dart';
import 'package:binance_cl/routes/app_pages.dart';
import 'package:binance_cl/screens/auth/controllers/auth_controller.dart';
import 'package:binance_cl/shared/action_button.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:pinput/pinput.dart';

class VerifyNumber extends StatefulWidget {
  const VerifyNumber({Key? key}) : super(key: key);

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  AuthController authController = Get.find();
  final controller = TextEditingController();
  final focusNode = FocusNode();
  bool showError = false;
  var borderColor = const Color.fromRGBO(114, 178, 238, 1);
  var errorColor = const Color.fromRGBO(255, 234, 238, 1);
  var fillColor = const Color.fromRGBO(222, 231, 240, .57);

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: TextStyle(
      fontSize: fontSize(22),
      color: kWhiteColor,
    ),
    decoration: BoxDecoration(
      color: kBackgroundColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kPrimaryColor),
    ),
  );

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(logo, width: widthSize(40)),
                      SizedBox(width: widthSize(3)),
                      const Align(
                        child: CText(
                          text: "BOBOCOIN",
                          color: kPrimaryColor,
                          size: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: heightSize(20)),
                  SizedBox(
                    height: constraints.maxHeight * 0.65,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CText(
                            text: "Verify Account",
                            color: kPrimaryColor,
                            size: 35,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: heightSize(20)),
                          const CText(
                            text:
                                "Please enter the CODE sent to your phone \nnumber or email address in the boxes below.",
                            color: kTextColor,
                            size: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                          SizedBox(height: constraints.maxHeight * 0.1),
                          SizedBox(
                            height: 68,
                            child: Pinput(
                              length: 6,
                              controller: controller,
                              focusNode: focusNode,
                              defaultPinTheme: defaultPinTheme,
                              onCompleted: (pin) {
                                setState(() => showError = pin != '555555');
                              },
                              focusedPinTheme: defaultPinTheme.copyWith(
                                height: 68,
                                width: 64,
                                decoration:
                                    defaultPinTheme.decoration!.copyWith(
                                  border: Border.all(color: borderColor),
                                ),
                              ),
                              errorPinTheme: defaultPinTheme.copyWith(
                                decoration: BoxDecoration(
                                  color: errorColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  ActionButton(
                    text: "Verify",
                    callback: () {
                      Get.toNamed(Routes.MAIN_APP);
                    },
                    textColor: kBackgroundColor,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: heightSize(40)),
                ],
              );
            }),
          ),
        ));
  }
}
