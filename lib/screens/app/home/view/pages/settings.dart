import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/routes/app_pages.dart';
import 'package:binance_cl/screens/app/wallets/controller/wallets_controller.dart';
import 'package:binance_cl/services/storage.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/shared/custom_toast.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart' hide Trans;

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WalletsController walletController = Get.find();
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
                  SizedBox(height: constraints.maxHeight * 0.02),
                  // const Align(
                  // child: CText(
                  //   text: "BOBOCOIN",
                  //   color: kPrimaryColor,
                  //   size: 30,
                  //   fontWeight: FontWeight.w700,
                  // ),
                  // ),
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
                  Obx(
                    () => CText(
                      text: "Hi, ${walletController.userData.value.fullname}",
                      color: kWhiteColor,
                      size: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: heightSize(10)),
                  Obx(
                    () => CText(
                      text:
                          "UID: ${walletController.userData.value.id!.substring(0, 5)}",
                      color: kText2Color,
                      size: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: heightSize(30)),
                  GestureDetector(
                    onTap: () {
                      cToast(
                          title: "Notice",
                          message:
                              "KYC data not availabe. Please try again later.");
                    },
                    child: Container(
                      height: heightSize(70),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Values().boxRadius2),
                          border: Border.all(color: kPrimaryColor)),
                      child: const Center(
                        child: CText(
                          text: "Complete Verification Lv.1",
                          color: kPrimaryColor,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: heightSize(30)),
                  Expanded(
                    child: Column(
                      children: [
                        // item(
                        //   text: "My Fee Rates",
                        //   icon: Entypo.credit,
                        //   callback: () {
                        //     Get.toNamed(Routes.SETTINGS);
                        //   },
                        // ),
                        item(
                          text: "Security",
                          icon: Entypo.shield,
                          callback: () {
                            cToast(
                                title: "Notice",
                                message:
                                    "Please complete your initial user verification level");
                          },
                        ),
                        item(
                          text: "Network Test",
                          icon: Entypo.bar_graph,
                          callback: () {
                            Get.toNamed(Routes.NETWORK_TEST);
                          },
                        ),
                        item(
                          text: "User Feedback",
                          icon: Entypo.news,
                          callback: () {
                            cToast(
                                title: "Notice",
                                message:
                                    "Please complete your initial user verification level");
                          },
                        ),
                        item(
                          text: "About Us",
                          icon: Entypo.info_with_circle,
                          callback: () {},
                        ),
                        item(
                          text: "Rate Our App",
                          icon: Entypo.thumbs_up,
                          callback: () {},
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            await Storage.eraseMemory();
                            Get.offAllNamed(Routes.SIGNIN_SCREEN);
                          },
                          child: Container(
                            height: heightSize(70),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: kContainerColor,
                              borderRadius:
                                  BorderRadius.circular(Values().boxRadius2),
                              //border: Border.all(color: kPrimaryColor),
                            ),
                            child: const Center(
                              child: CText(
                                text: "Log Out",
                                color: kText2Color,
                                size: 17,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: heightSize(30)),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ));
  }

  Widget item(
      {required String text,
      required IconData icon,
      required VoidCallback callback}) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        margin: const EdgeInsets.only(bottom: 40),
        child: Row(
          children: [
            Icon(
              icon,
              color: kText2Color,
              size: 25,
            ),
            SizedBox(width: widthSize(20)),
            CText(
              text: text,
              size: 18,
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: kText2Color,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
