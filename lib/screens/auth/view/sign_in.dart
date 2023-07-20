import 'dart:developer';

import 'package:binance_cl/constants/assets_path.dart';
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

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
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
                           CText(
                            text: "signin_msg".tr(),
                            color: kPrimaryColor,
                            size: 35,
                            fontWeight: FontWeight.w400,
                            height: 1.2,
                          ),
                          SizedBox(height: heightSize(20)),
                           CText(
                            text: "login_msg".tr(),
                            color: kTextColor,
                            size: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: constraints.maxHeight * 0.04),
                          Obx(
                            () => Row(
                              children: [
                                authController.phoneInput.value == true
                                    ?  CText(
                                        text: "phone_msg".tr(),
                                        color: kTextColor,
                                        size: 14,
                                        fontWeight: FontWeight.w600,
                                      )
                                    :  CText(
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
                          //SizedBox(height: heightSize(10)),
                          Obx(
                            () => authController.phoneInput.value == true
                                ? AuthTextField(
                                    hint: "phone_input_msg".tr(),
                                    controller: authController
                                        .phoneNumberSigninController,
                                    error: authController.error.value,
                                    inputType: TextInputType.text,
                                    validFunction: (v) => v!,
                                    onSavedFunction: (s) => {
                                      if (s.isNotEmpty)
                                        {
                                          authController.error.value = '',
                                          authController
                                              .phoneNumberSignin.value = s,
                                          //print(email);
                                        }
                                      else
                                        {
                                          authController.error.value = "Add ",
                                          authController
                                              .phoneNumberSignin.value = ''
                                        }
                                    },
                                  )
                                : AuthTextField(
                                    hint: "email_input_msg".tr(),
                                    controller:
                                        authController.emailSigninController,
                                    error: authController.error.value,
                                    inputType: TextInputType.emailAddress,
                                    validFunction: (v) => v!,
                                    onSavedFunction: (s) => {
                                      if (s.isValidEmail())
                                        {
                                          authController.error.value = '',
                                          authController.emailSignin.value = s,
                                          //print(email);
                                        }
                                      else
                                        {
                                          authController.error.value = "Add ",
                                          authController.emailSignin.value = ''
                                        }
                                    },
                                  ),
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
                            hint: "password_input_msg".tr(),
                            controller: authController.passwordSigninController,
                            error: authController.error.value,
                            inputType: TextInputType.text,
                            validFunction: (v) => v!,
                            onSavedFunction: (s) => {
                              if (s.isNotEmpty)
                                {
                                  authController.error.value = '',
                                  authController.passwordSignin.value = s,
                                  //print(email);
                                }
                              else
                                {
                                  authController.error.value = "Add ",
                                  authController.passwordSignin.value = ''
                                }
                            },
                          ),
                          SizedBox(height: heightSize(30)),
                           CText(
                            text: "forget_msg".tr(),
                            color: kTextColor,
                            size: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: heightSize(15)),
                           CText(
                            text: "recover_msg".tr(),
                            color: kPrimaryColor,
                            size: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: heightSize(100)),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  ActionButton(
                    text: "login_btn".tr(),
                    callback: () {
                      log("hererr");
                      if (authController.phoneInput.value == true &&
                          authController.phoneNumberSignin.value.isEmpty) {
                        showHelpSnackBar(
                            context: context,
                            title: "Notice",
                            messages: "Your phone number cannot be empty");
                      } else if (authController.phoneInput.value == false &&
                          authController.emailSignin.value.isEmpty) {
                        showHelpSnackBar(
                            context: context,
                            title: "Notice",
                            messages: "Your email cannot be empty");
                      } else if (authController.passwordSignin.value.isEmpty) {
                        showHelpSnackBar(
                            context: context,
                            title: "Notice",
                            messages: "Your password is required.");
                      } else {
                        log("here");
                        if (authController.phoneInput.value == true) {
                          authController.loginPhoneToAccount(context);
                        } else {
                          authController.loginEmailToAccount(context);
                        }
                      }
                      //Get.toNamed(Routes.MAIN_APP);
                    },
                    textColor: kBackgroundColor,
                    fontWeight: FontWeight.w500,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CText(
                      text: "signin_here_msg".tr(),
                      color: kPrimaryColor,
                      size: 14,
                      fontWeight: FontWeight.w600,
                      onClick: () {
                        Get.toNamed(Routes.SIGNUP_SCREEN);
                      },
                    ),
                  ),
                  SizedBox(height: heightSize(30)),
                ],
              );
            }),
          ),
        ));
  }
}
