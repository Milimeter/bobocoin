import 'dart:io';

import 'package:binance_cl/constants/get_wallet_addresses.dart';
import 'package:binance_cl/constants/value.dart';
import 'package:binance_cl/screens/app/markets/controller/markets_controller.dart';
import 'package:binance_cl/shared/action_button.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/shared/custom_toast.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:binance_cl/utils/utilities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coingecko_api/data/market.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ReceiveCrypto extends StatefulWidget {
  const ReceiveCrypto({super.key});

  @override
  State<ReceiveCrypto> createState() => _ReceiveCryptoState();
}

class _ReceiveCryptoState extends State<ReceiveCrypto> {
  MarketsController marketsController = Get.find();
  ScreenshotController screenshotController = ScreenshotController();

  String symbol = "";
  String name = "";
  String walletAddress = "";
  late Market currentAsset;
  getData() async {
    symbol = Get.arguments["symbol"];
    name = Get.arguments["name"];
    currentAsset = marketsController.coinList!.data
        .where((element) => element.symbol.toUpperCase() == symbol)
        .first;
    walletAddress =
        await ReturnWalletAddress(symbol: symbol).getWalletAddress();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.02),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.close),
                  ),
                  SizedBox(height: heightSize(10)),
                  const CText(
                    text: "Deposit",
                    color: kTextColor,
                    size: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: heightSize(10)),
                  Container(
                    height: heightSize(70),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    decoration: BoxDecoration(
                      color: kContainerColor,
                      borderRadius: BorderRadius.circular(Values().boxRadius2),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          child: CachedNetworkImage(
                            imageUrl: currentAsset.image!,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  // colorFilter: ColorFilter.mode(
                                  //     Colors.red, BlendMode.colorBurn),
                                ),
                              ),
                            ),
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        SizedBox(width: widthSize(16)),
                        CText(
                          text: currentAsset.symbol.toUpperCase(),
                          size: 18,
                          fontFamily: "Poppins-SemiBold",
                        ),
                        SizedBox(width: widthSize(6)),
                        CText(
                          text: currentAsset.name,
                          size: 14,
                          color: kText2Color,
                        ),
                        const Spacer(),
                        const Icon(
                          Entypo.chevron_right,
                          color: kText2Color,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(20)),
                  Screenshot(
                    controller: screenshotController,
                    child: Container(
                      height: heightSize(350),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 10),
                      decoration: BoxDecoration(
                        color: kContainerColor,
                        borderRadius:
                            BorderRadius.circular(Values().boxRadius2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CText(
                            text: "Wallet Address",
                            size: 14,
                            fontFamily: "Poppins-SemiBold",
                          ),
                          SizedBox(height: heightSize(10)),
                          Align(
                            child: PrettyQr(
                              //image: NetworkImage(currentAsset.image!),
                              size: 200,
                              data: walletAddress,
                              errorCorrectLevel: QrErrorCorrectLevel.M,
                              roundEdges: true,
                              elementColor: kTextColor,
                            ),
                          ),
                          SizedBox(height: heightSize(7)),
                          const Divider(),
                          SizedBox(height: heightSize(7)),
                          Row(
                            children: [
                              CText(
                                text: truncate(walletAddress, length: 30),
                                size: 14,
                                fontFamily: "Poppins-SemiBold",
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  ClipboardData data =
                                      ClipboardData(text: walletAddress);
                                  await Clipboard.setData(data);
                                  cToast(
                                      title: 'Notice',
                                      message: "Copied $symbol address");
                                },
                                child: const Icon(
                                  Entypo.documents,
                                  color: kTextColor,
                                ),
                              ),
                              SizedBox(width: widthSize(10)),
                              GestureDetector(
                                onTap: () async {
                                  ClipboardData data =
                                      ClipboardData(text: walletAddress);
                                  await Clipboard.setData(data);
                                  cToast(
                                      title: 'Notice',
                                      message: "Copied $symbol address");
                                },
                                child: const CText(
                                  text: "Copy",
                                  size: 14,
                                  fontFamily: "Poppins-SemiBold",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: heightSize(13)),
                  Container(
                    height: heightSize(230),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 10),
                    decoration: BoxDecoration(
                      color: kContainerColor,
                      borderRadius: BorderRadius.circular(Values().boxRadius2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CText(
                          text: "Notice",
                          size: 14,
                          fontFamily: "Poppins-SemiBold",
                        ),
                        SizedBox(height: heightSize(13)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CText(
                              text: "•",
                              size: 30,
                              fontFamily: "Poppins-SemiBold",
                            ),
                            SizedBox(width: widthSize(10)),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(height: heightSize(5)),
                                  CText(
                                    text:
                                        "Please make sure that only $symbol deposit is made via ths address. Otherwise, your deposited funds will not be added to your available balance - nor will it be refunded.",
                                    size: 14,
                                    height: 1.3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CText(
                              text: "•",
                              size: 30,
                              fontFamily: "Poppins-SemiBold",
                            ),
                            SizedBox(width: widthSize(10)),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(height: heightSize(5)),
                                  const CText(
                                    text:
                                        "Please make sure that your Bobocoin deposit address is correct. Otherwise, your deposited funds will not be added to your available balance - nor will it be refunded.",
                                    size: 14,
                                    height: 1.3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CText(
                              text: "•",
                              size: 30,
                              fontFamily: "Poppins-SemiBold",
                            ),
                            SizedBox(width: widthSize(10)),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(height: heightSize(5)),
                                  const CText(
                                    text:
                                        "If your current address is used, a maximum 12 block confimations are required before your deposited funds can be added to your available balance. ",
                                    size: 14,
                                    height: 1.3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSize(20)),
                  ActionButton(
                    text: "Share",
                    callback: () async {
                      await screenshotController
                          .capture(delay: const Duration(milliseconds: 10))
                          .then((Uint8List? image) async {
                        if (image != null) {
                          final directory =
                              await getApplicationDocumentsDirectory();
                          final imagePath =
                              await File('${directory.path}/image.png')
                                  .create();
                          await imagePath.writeAsBytes(image);

                          /// Share Plugin
                          await Share.shareFiles([imagePath.path]);
                        }
                      });
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
