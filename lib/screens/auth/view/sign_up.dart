import 'dart:developer';
import 'dart:math' as mth;

import 'package:binance_cl/constants/assets_path.dart';
import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/routes/app_pages.dart';
import 'package:binance_cl/screens/auth/controllers/auth_controller.dart';
import 'package:binance_cl/services/extensions.dart';
import 'package:binance_cl/shared/action_button.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/shared/custom_textfield.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:binance_cl/utils/utilities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:slider_captcha/slider_capchar.dart';
import 'package:country_code_picker/country_code_picker.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();

    return WillPopScope(
      onWillPop: () async {
        authController.country.value = "中国";
        return true;
      },
      child: Scaffold(
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
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CText(
                              text: "create_acc".tr(),   
                              color: kPrimaryColor,
                              size: 35,
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                            SizedBox(height: heightSize(20)),
                            CText(
                              text: "open_acc".tr(),
                              color: kTextColor,
                              size: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            //SizedBox(height: constraints.maxHeight * 0.05),
                            SizedBox(height: heightSize(30)),
                            CText(
                              text: "full_name".tr(),
                              color: kTextColor,
                              size: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: heightSize(20)),
                            AuthTextField(
                              hint: "full_name_input",
                              controller:
                                  authController.fullnameSignupController,
                              error: authController.error.value,
                              inputType: TextInputType.text,
                              validFunction: (v) => v!,
                              onSavedFunction: (s) => {
                                if (s.isNotEmpty)
                                  {
                                    authController.error.value = '',
                                    authController.fullnameSignup.value = s,
                                    //print(email);
                                  }
                                else
                                  {
                                    authController.error.value = "Add ",
                                    authController.fullnameSignup.value = ''
                                  }
                              },
                            ),
                            Obx(
                              () => Row(
                                children: [
                                  authController.phoneInput.value == true
                                      ? CText(
                                          text: "phone_msg".tr(),
                                          color: kTextColor,
                                          size: 14,
                                          fontWeight: FontWeight.w600,
                                        )
                                      : CText(
                                          text: "email_msg".tr(),
                                          color: kTextColor,
                                          size: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  const Spacer(),
                                  authController.phoneInput.value == true
                                      ? CText(
                                          text: "email_msg".tr(),
                                          color: kPrimaryColor,
                                          size: 14,
                                          fontWeight: FontWeight.w600,
                                          onClick: () {
                                            authController.changeToEmail();
                                          },
                                        )
                                      : CText(
                                          text: "phone_msg".tr(),
                                          color: kPrimaryColor,
                                          size: 14,
                                          fontWeight: FontWeight.w600,
                                          onClick: () {
                                            authController.changeToPhone();
                                          },
                                        ),
                                ],
                              ),
                            ),
                            Obx(
                              () => authController.phoneInput.value == true
                                  ? AuthTextField(
                                      hint: "phone_input_msg".tr(),
                                      controller: authController
                                          .phoneNumberSignupController,
                                      error: authController.error.value,
                                      inputType: TextInputType.phone,
                                      validFunction: (v) => v!,
                                      onSavedFunction: (s) => {
                                        if (s.isNumeric())
                                          {
                                            authController.error.value = '',
                                            authController
                                                .phoneNumberSignup.value = s,
                                            //print(email);
                                          }
                                        else
                                          {
                                            authController.error.value = "Add ",
                                            authController
                                                .phoneNumberSignup.value = ''
                                          }
                                      },
                                    )
                                  : AuthTextField(
                                      hint: "email_input_msg".tr(),
                                      controller:
                                          authController.emailSignupController,
                                      error: authController.error.value,
                                      inputType: TextInputType.emailAddress,
                                      validFunction: (v) => v!,
                                      onSavedFunction: (s) => {
                                        if (s.isValidEmail())
                                          {
                                            authController.error.value = '',
                                            authController.emailSignup.value =
                                                s,
                                            //print(email);
                                          }
                                        else
                                          {
                                            authController.error.value = "Add ",
                                            authController.emailSignup.value =
                                                ''
                                          }
                                      },
                                    ),
                            ),
                            SizedBox(height: heightSize(20)),
                            CText(
                              text: "choose_count".tr(),
                              color: kTextColor,
                              size: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: heightSize(10)),
                            Row(
                              children: [
                                Container(
                                  height: heightSize(60),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 4),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(
                                          Values().boxRadius2)),
                                  child: Center(
                                    child: SizedBox(
                                      width: widthSize(110),
                                      child: CountryCodePicker(
                                        dialogBackgroundColor: kBackgroundColor,
                                        backgroundColor: kBackgroundColor,
                                        barrierColor: kBackgroundColor,
                                        padding: const EdgeInsets.all(1.0),
                                        onInit: (s) {
                                          //log(s.toString());
                                          authController.countryCode.value =
                                              s.toString();
                                        },
                                        onChanged: (s) {
                                          log(s.code!);
                                          authController.country.value =
                                              s.name!;
                                          log(s.name!);
                                          authController.countryCode.value =
                                              s.toString();
                                        },

                                        initialSelection: 'CN',
                                        favorite: const ['+86', 'CN'],
                                        showCountryOnly: false,
                                        showOnlyCountryWhenClosed: false,
                                        alignLeft: false,
                                        flagWidth: 40,
                                        // textStyle: const TextStyle(
                                        //   color: kWhiteColor,
                                        //   fontWeight: FontWeight.w400,
                                        //   fontSize: 16,
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Container(
                                    height: heightSize(55),
                                    width: constraints.maxWidth,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    decoration: BoxDecoration(
                                      color: kBackgroundColor,
                                      borderRadius: BorderRadius.circular(
                                          Values().boxRadius2),
                                      border: Border.all(color: kPrimaryColor),
                                    ),
                                    child: Obx(
                                      () => Align(
                                        alignment: Alignment.centerLeft,
                                        child: CText(
                                          text: authController.country.value,
                                          color: kTextColor,
                                          size: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: heightSize(30)),
                            CText(
                              text: "password_msg".tr(),
                              color: kTextColor,
                              size: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: heightSize(20)),
                            AuthTextField(
                              hint: "password_msg".tr(),
                              controller:
                                  authController.passwordSignupController,
                              error: authController.error.value,
                              inputType: TextInputType.text,
                              validFunction: (v) => v!,
                              onSavedFunction: (s) => {
                                if (s.isNotEmpty)
                                  {
                                    authController.error.value = '',
                                    authController.passwordSignup.value = s,
                                    //print(email);
                                  }
                                else
                                  {
                                    authController.error.value = "Add ",
                                    authController.passwordSignup.value = ''
                                  }
                              },
                            ),
                            SizedBox(height: heightSize(30)),
                            CText(
                              text: "repeat_pass".tr(),
                              color: kTextColor,
                              size: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: heightSize(20)),
                            AuthTextField(
                              hint: "password_msg".tr(),
                              controller:
                                  authController.repeatPasswordSignupController,
                              error: authController.error.value,
                              inputType: TextInputType.text,
                              validFunction: (v) => v!,
                              onSavedFunction: (s) => {
                                if (s.isNotEmpty)
                                  {
                                    authController.error.value = '',
                                    authController.repeatPasswordSignup.value =
                                        s,
                                    //print(email);
                                  }
                                else
                                  {
                                    authController.error.value = "Add ",
                                    authController.repeatPasswordSignup.value =
                                        ''
                                  }
                              },
                            ),
                            SizedBox(height: heightSize(20)),
                            ActionButton(
                              text: "create_yr_acc".tr(),
                              callback: () {
                                if (authController
                                    .fullnameSignup.value.isEmpty) {
                                  showHelpSnackBar(
                                      context: context,
                                      title: "Notice",
                                      messages: "Your full name is required.");
                                } else if (authController
                                    .passwordSignup.value.isEmpty) {
                                  showHelpSnackBar(
                                      context: context,
                                      title: "Notice",
                                      messages: "Your password is required.");
                                } else if (authController
                                        .passwordSignup.value !=
                                    authController.repeatPasswordSignup.value) {
                                  showHelpSnackBar(
                                      context: context,
                                      title: "Notice",
                                      messages:
                                          "Your password does not match the repeat password");
                                } else if (authController.phoneInput.value ==
                                        true &&
                                    authController //
                                        .phoneNumberSignup
                                        .value
                                        .isEmpty) {
                                  showHelpSnackBar(
                                      context: context,
                                      title: "Notice",
                                      messages:
                                          "Your phone number cannot be empty");
                                } else if (authController.phoneInput.value ==
                                        false &&
                                    authController.emailSignup.value.isEmpty) {
                                  showHelpSnackBar(
                                      context: context,
                                      title: "Notice",
                                      messages: "Your email cannot be empty");
                                } else {
                                  if (authController.phoneInput.value == true) {
                                    mth.Random random = mth.Random();
                                    int randomNumber = random.nextInt(1000000);
                                    authController.emailSignup.value =
                                        "$randomNumber@@@";
                                    authController.checkPhoneExists(context);
                                  } else {
                                    mth.Random random = mth.Random();
                                    int randomNumber = random.nextInt(100000);
                                    authController.phoneNumberSignup.value =
                                        "$randomNumber@";
                                    authController.checkEmailExists(context);
                                  }
                                }
                                // Get.to(() => const Captcha());
                                //Get.toNamed(Routes.VERIFY_NUMBER);
                              },
                              textColor: kBackgroundColor,
                              fontWeight: FontWeight.w500,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CText(
                                  text: "do_you_acc".tr(),
                                  color: kTextColor,
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                CText(
                                    text: "sign".tr(),
                                    color: kPrimaryColor,
                                    size: 14,
                                    fontWeight: FontWeight.w600,
                                    onClick: () {
                                      Get.back();
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
            ),
          )),
    );
  }
}

class Captcha extends StatefulWidget {
  const Captcha({Key? key}) : super(key: key);

  @override
  State<Captcha> createState() => _CaptchaState();
}

class _CaptchaState extends State<Captcha> {
  final SliderController controller = SliderController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: heightSize(400),
              margin: const EdgeInsets.only(top: 100),
              child: SliderCaptcha(
                controller: controller,
                image: Image.asset(
                  captcha,
                  fit: BoxFit.cover,
                ),
                colorBar: kPrimaryColor,
                colorCaptChar: kPrimaryColor,
                onConfirm: (value) {
                  if (value == true) {
                    log("correct");
                    Get.toNamed(Routes.VERIFY_NUMBER);
                  } else {
                    log("wrong");
                    Future.delayed(const Duration(seconds: 1)).then(
                      (value) {
                        controller.create();
                        log("here");
                      },
                    );
                  }
                },
              ),
            ),
            const Spacer(),
            const CText(
              text: "Powererd by BoBocoin",
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
              size: 14,
            ),
            SizedBox(height: heightSize(20))
          ],
        ),
      ),
    );
  }
}
