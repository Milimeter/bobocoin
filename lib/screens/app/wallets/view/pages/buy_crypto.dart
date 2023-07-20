import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class BuyCrypto extends StatefulWidget {
  const BuyCrypto({Key? key}) : super(key: key);

  @override
  State<BuyCrypto> createState() => _BuyCryptoState();
}

class _BuyCryptoState extends State<BuyCrypto> {
  final GlobalKey webViewKey = GlobalKey();
  String symbol = "";
  String walletAddress = "";
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  double progress = 0;
  late PullToRefreshController pullToRefreshController;
  @override
  void initState() {
    symbol = Get.arguments["symbol"];
    walletAddress = Get.arguments["walletAddress"];
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          key: webViewKey,
          initialUrlRequest: URLRequest(
              url: Uri.parse(
            'https://widget.onramper.com?color=EFAD25&darkMode=true&apiKey=pk_prod_iqPZG1RTUMOpbAa2woZxl_5TWAFUFN3laoGC7mqCm2Q0&defaultCrypto=$symbol&wallets=$symbol:$walletAddress',
          )),
          initialOptions: options,
          pullToRefreshController: pullToRefreshController,
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          androidOnPermissionRequest: (controller, origin, resources) async {
            return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT);
          },
        ),
      ),
    );
  }
}
