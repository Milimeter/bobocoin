import 'dart:convert';
import 'dart:developer';

import 'package:binance_cl/models/binance/order_book.dart';
import 'package:binance_cl/models/binance/spot_account.dart';
import 'package:binance_cl/shared/custom_toast.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart' hide Trans;
import 'package:http/http.dart' as http;

class TradeController extends GetxController {
  RxBool isBuySelected = RxBool(true);
  RxBool isSellSelected = RxBool(false);
  RxBool load = RxBool(false);

  RxBool is25PercentSelected = RxBool(true);
  RxBool is50PercentSelected = RxBool(false);
  RxBool is75PercentSelected = RxBool(false);
  RxBool is100PercentSelected = RxBool(false);
  Rx<OrderBook> orderBook = OrderBook().obs;
  RxString orderBookSymbol = 'BTCUSDT'.obs;
  RxString orderTickerPrice = "0.00".obs;
  Rx<SpotAccount> spotAccount = SpotAccount().obs;

  RxString tradePair = RxString('BTCUSDT');

  String baseUrl = "https://testnet.binance.vision";
  RxString spotAccountBalance = "0.00".obs;
  Rx<Balance> balance = Balance().obs;
  RxString totalBasePair = "0.00".obs;
  RxString totalSourcePair = "0.00".obs;
  String binanceApiSecret =
      "NjKr4NFIFBheN8jabMyTfmCIpf2I1dAm5YxBNzNN7YBwksvePVlef61jeeLJeDO3";
  String binanceApiKey =
      "31oh057geDxqKblhjrQ6mAkylFdbNlrVkchxfMMfH37owwOD8gAFxayzcFizLfOs";

  selectBuyTab() {
    isBuySelected.value = true;
    isSellSelected.value = false;
  }

  selectSellTab() {
    isSellSelected.value = true;
    isBuySelected.value = false;
  }

  select25PercentTab() {
    calculateAmountTotal(25);
    is25PercentSelected.value = true;
    is50PercentSelected.value = false;
    is75PercentSelected.value = false;
    is100PercentSelected.value = false;
  }

  select50PercentTab() {
    calculateAmountTotal(50);
    is50PercentSelected.value = true;
    is25PercentSelected.value = false;
    is75PercentSelected.value = false;
    is100PercentSelected.value = false;
  }

  select75PercentTab() {
    calculateAmountTotal(75);
    is75PercentSelected.value = true;
    is25PercentSelected.value = false;
    is50PercentSelected.value = false;
    is100PercentSelected.value = false;
  }

  select100PercentTab() {
    calculateAmountTotal(100);
    is100PercentSelected.value = true;
    is25PercentSelected.value = false;
    is50PercentSelected.value = false;
    is75PercentSelected.value = false;
  }

  List<String> allowedTrading = [
    "BNBBUSD",
    "BTCBUSD",
    "ETHBUSD",
    "LTCBUSD",
    "TRXBUSD",
    "XRPBUSD",
    "BNBUSDT",
    "BTCUSDT",
    "ETHUSDT",
    "LTCUSDT",
    "TRXUSDT",
    "XRPUSDT",
    "BNBBTC",
    "ETHBTC",
    "LTCBTC",
    "TRXBTC",
    "XRPBTC",
    "LTCBNB",
    "TRXBNB",
    "XRPBNB",
  ];

  getSpotAccount() async {
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    var key = utf8.encode(binanceApiSecret);
    var bytes = utf8.encode("timestamp=$timestamp");
    Hmac hmacSha256 = Hmac(sha256, key);
    var signature = hmacSha256.convert(bytes);

    Uri uri = Uri.parse(
        "$baseUrl/api/v3/account?timestamp=$timestamp&signature=$signature");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "X-MBX-APIKEY": binanceApiKey,
    };

    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var results = jsonDecode(response.body);
      // log(results.toString());
      spotAccount.value = SpotAccount.fromJson(results);
      getCorrespondingAccountBalance('USDT');
      calculateAmountTotal(25);
      // log("spot account: ${spotAccount.value.canTrade}");
    } else {
      log(response.statusCode.toString());
      log(response.body);
      log("Unable to get spot account details");
      cToast(title: "Notice", message: "Unable to get spot account details");
    }
  }

  getCorrespondingAccountBalance(toPair) {
    balance.value = spotAccount.value.balances!
        .firstWhere((element) => element.asset == toPair);
    log(balance.value.asset!);
    log(balance.value.free!);
    log(balance.value.locked!);
  }

  calculateAmountTotal(int percent) {
    totalBasePair.value =
        (percent / 100 * double.parse(balance.value.free!)).toString();
    log(totalBasePair.value);
    totalSourcePair.value = (double.parse(totalBasePair.value) /
            double.parse(orderTickerPrice.value))
        .toStringAsFixed(2);
  }

  getBinanceSymbolOrderBook() async {
    Uri uri = Uri.parse(
        "$baseUrl/api/v3/depth?symbol=${orderBookSymbol.value}&limit=7");
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    // log(uri.toString());

    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var results = jsonDecode(response.body);
      orderBook.value = OrderBook.fromJson(results);
      getBinanceSymbolTickerPrice();
      //log(orderBook.value.asks!.length.toString());
    } else {
      log(response.statusCode.toString());
      log(response.body);
      log("Unable to get order book");
      cToast(title: "Notice", message: "Unable to get order book");
    }
  }

  getBinanceSymbolTickerPrice() async {
    Uri uri = Uri.parse(
        "$baseUrl/api/v3/ticker/price?symbol=${orderBookSymbol.value}");
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    // log(uri.toString());

    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      //log(response.body);
      var results = jsonDecode(response.body);
      orderTickerPrice.value = results['price'];
      //log(orderBook.value.asks!.length.toString());
    } else {
      log(response.statusCode.toString());
      log(response.body);
      log("Unable to get ticker price");
      cToast(title: "Notice", message: "Unable to get order book");
    }
  }

  createSpotOrder() async {
    load.value = true;
    String side = isBuySelected.value == true ? "BUY" : "SELL";
    var timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    var key = utf8.encode(binanceApiSecret);
    var bytes = utf8.encode(
        "symbol=${tradePair.value}&side=$side&type=MARKET&quantity=${totalSourcePair.value}&timestamp=$timestamp");
    Hmac hmacSha256 = Hmac(sha256, key);
    var signature = hmacSha256.convert(bytes);

    Uri uri = Uri.parse(
        "$baseUrl/api/v3/order?symbol=${tradePair.value}&side=$side&type=MARKET&quantity=${totalSourcePair.value}&timestamp=$timestamp&signature=$signature");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "X-MBX-APIKEY": binanceApiKey,
    };
    //log(uri.toString());
    http.Response response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      load.value = false;
      var results = jsonDecode(response.body);
      // log(results.toString());
      cToast(title: "Notice", message: "Spot MARKET order created");
      // log("spot account: ${spotAccount.value.canTrade}");
    } else {
      load.value = false;
      log(response.statusCode.toString());
      log(response.body);
      log("Unable to create spot MARKET order");
      cToast(title: "Notice", message: "Unable to create spot MARKET order");
    }
  }

  @override
  void onReady() {
    getBinanceSymbolOrderBook();
    getSpotAccount();
    super.onReady();
  }
}
