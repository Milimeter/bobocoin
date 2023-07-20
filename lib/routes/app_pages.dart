// ignore_for_file: constant_identifier_names

import 'package:binance_cl/screens/app/home/binding/home_binding.dart';
import 'package:binance_cl/screens/app/home/view/pages/exchange_service/convert_crypto.dart';
import 'package:binance_cl/screens/app/home/view/pages/exchange_service/crypto_conversion_selector.dart';
import 'package:binance_cl/screens/app/home/view/pages/help_and_support.dart';
import 'package:binance_cl/screens/app/home/view/pages/language.dart';
import 'package:binance_cl/screens/app/home/view/pages/launch_pad.dart';
import 'package:binance_cl/screens/app/home/view/pages/network_test.dart';
import 'package:binance_cl/screens/app/home/view/pages/notification.dart';
import 'package:binance_cl/screens/app/home/view/pages/qr_scanner.dart';
import 'package:binance_cl/screens/app/home/view/pages/referral.dart';
import 'package:binance_cl/screens/app/home/view/pages/settings.dart';
import 'package:binance_cl/screens/app/main_app.dart';
import 'package:binance_cl/screens/app/markets/binding/markets_binding.dart';
import 'package:binance_cl/screens/app/markets/view/pages/market_info.dart';
import 'package:binance_cl/screens/app/trade/binding/trade_binding.dart';
import 'package:binance_cl/screens/app/wallets/binding/wallets_binding.dart';
import 'package:binance_cl/screens/app/wallets/view/pages/buy_crypto.dart';
import 'package:binance_cl/screens/app/wallets/view/pages/deposit_crypto.dart';
import 'package:binance_cl/screens/app/wallets/view/pages/deposit_selector.dart';
import 'package:binance_cl/screens/app/wallets/view/pages/internal_transfer.dart';
import 'package:binance_cl/screens/app/wallets/view/pages/withdrawal_amount_input.dart';
import 'package:binance_cl/screens/app/wallets/view/pages/withdrawal_selector.dart';
import 'package:binance_cl/screens/auth/binding/auth_binding.dart';
import 'package:binance_cl/screens/auth/view/pages/verify_number.dart';
import 'package:binance_cl/screens/auth/view/sign_in.dart';
import 'package:binance_cl/screens/auth/view/sign_up.dart';
import 'package:binance_cl/screens/splash_screen.dart';
import 'package:get/get.dart' hide Trans;

part 'app_routes.dart';

class AppPages {
  static const SPLASHSCREEN = Routes.INITIAL;
  static final routes = [
    GetPage(
      name: SPLASHSCREEN,
      page: () => const SplashScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.SIGNIN_SCREEN,
      page: () => const SigninScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.SIGNUP_SCREEN,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: Routes.VERIFY_NUMBER,
      page: () => const VerifyNumber(),
    ),
    GetPage(name: Routes.MAIN_APP, page: () => const MainApp(), bindings: [
      MarketsBinding(),
      HomeBinding(),
      TradeBinding(),
      WalletsBinding(),
    ]),
    GetPage(
      name: Routes.MARKET_INFORMATION,
      page: () => const MarketInfo(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const Settings(),
    ),
    GetPage(
      name: Routes.LANGUAGE,
      page: () => const Language(),
    ),
    GetPage(
      name: Routes.HELP_AND_SUPPORT,
      page: () => const HelpAndSupport(),
    ),
    GetPage(
      name: Routes.NETWORK_TEST,
      page: () => const NetworkTest(),
    ),
    GetPage(
      name: Routes.INTERNAL_TRANSFER,
      page: () => const InternalTransfer(),
    ),
    GetPage(
      name: Routes.DEPOSIT_SELECTOR,
      page: () => const DepositSelector(),
    ),
    GetPage(
      name: Routes.REFERRALS,
      page: () => const Referral(),
    ),
    GetPage(
      name: Routes.CRYPTO_TO_CRYPTO_SELECTOR,
      page: () => const CryptoToCryptoSelector(),
    ),
    GetPage(
      name: Routes.CRYPTO_TO_CRYPTO_CONVERTER,
      page: () => const ConvertCrypto(),
    ),
    GetPage(
      name: Routes.LAUNCHPADS,
      page: () => const LaunchPad(),
    ),
    GetPage(
      name: Routes.BUY_CRYPTO_ASSET,
      page: () => const BuyCrypto(),
      
    ),
    GetPage(
      name: Routes.RECEIVE_CRYPTO,
      page: () => const ReceiveCrypto(),

    ),
    GetPage(
      name: Routes.QR_SCANNER,
      page: () => const QRScanner(),
    ),
    GetPage(
      name: Routes.APP_NOTIFICATION,
      page: () => const AppNotifications(),
    ),
    GetPage(
      name: Routes.WITHDRAWAL_SELECTOR,
      page: () => const WithdrawalSelector(),
    ),
    GetPage(
      name: Routes.WITHDRAWAL_AMOUNT_INPUT,
      page: () => const WithdrawalAmountInput(),
    ),
  ];
}
