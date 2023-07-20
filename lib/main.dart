// ignore_for_file: library_private_types_in_public_api

import 'package:binance_cl/routes/app_pages.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/size-config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  TrustWalletCoreLib.init();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('zh'),
          Locale('ja'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const InitClass(),
      ),
    );
  });
}

class InitClass extends StatelessWidget {
  const InitClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      SizeConfig().init(constraints);
      return RestartWidget(
        child: GetMaterialApp(
          title: "Bobocoin",
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.SPLASHSCREEN,
          getPages: AppPages.routes,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            fontFamily: 'Outfit-Regular',
            brightness: Brightness.dark,
            backgroundColor: kBackgroundColor,
          ),
        ),
      );
    });
  }
}


class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({Key? key, required this.child}) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
