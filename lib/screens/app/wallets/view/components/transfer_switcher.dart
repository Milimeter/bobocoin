import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/screens/app/wallets/controller/wallets_controller.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart' hide Trans;

class TransferSwitcher extends StatelessWidget {
  const TransferSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WalletsController walletController = Get.find();
    return Container(
      height: heightSize(120),
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: kContainerColor,
        borderRadius: BorderRadius.circular(Values().boxRadius2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    const CText(
                      text: "From",
                      color: kText2Color,
                      size: 12,
                    ),
                    SizedBox(width: widthSize(13)),
                    Obx(
                      () => CText(
                        text: walletController.switchAccountTransferred.value ==
                                false
                            ? "Spot Account"
                            : "Futures Account",
                        key: UniqueKey(),
                        color: kTextColor,
                        size: 18,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: kTextColor,
                    )
                  ],
                ),
                const Spacer(),
                const Divider(),
                const Spacer(),
                Row(
                  children: [
                    const CText(
                      text: "From",
                      color: kText2Color,
                      size: 12,
                    ),
                    SizedBox(width: widthSize(13)),
                    Obx(
                      () => CText(
                        text: walletController.switchAccountTransferred.value ==
                                true
                            ? "Spot Account"
                            : "Futures Account",
                        key: UniqueKey(),
                        color: kTextColor,
                        size: 18,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: kTextColor,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: widthSize(10)),
          GestureDetector(
            onTap: () {
              walletController.switchAccountTransferred.value =
                  !walletController.switchAccountTransferred.value;
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: kText2Color.withOpacity(0.5),
              child: const Icon(
                Feather.shuffle,
                color: kPrimaryColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
