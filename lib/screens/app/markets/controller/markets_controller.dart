import 'dart:convert';
import 'dart:developer';

 import 'package:coingecko_api/coingecko_api.dart';
import 'package:coingecko_api/coingecko_result.dart';
import 'package:coingecko_api/data/market.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart' hide Trans;

class MarketsController extends GetxController {
  CoinGeckoApi coinGeckoApi = CoinGeckoApi();
  CoinGeckoResult<List<Market>>? coinList;
  Rx<Market>? selectedAsset;
  RxList<Candle> candles = RxList();
  RxString binancePair = RxString('BTCUSDT');
  RxString binanceInterval = RxString('30m');
  RxBool loadingData = RxBool(false);
  RxBool chartsError = RxBool(false);

  getCoinPrices() async {
    loadingData.value = true;
    coinList = await coinGeckoApi.coins.listCoinMarkets(vsCurrency: 'usd');

    // await coinGeckoApi.coins.getCoinData(id: "usdt").then((value) {
    //   value.data.
    // });
    if (coinList!.isError == false) {
      loadingData.value = false;
    }
    loadingData.value = false;
  }
  

  Future<List<double>> getSparkLinePrice({required String id}) async {
    try {
      var url = Uri.parse(
          'https://api.coingecko.com/api/v3/coins/$id?sparkline=true');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);

        List<double> price =
            List.from(decodedData['market_data']['sparkline_7d']['price']);
        return price;
      } else {
        log(response.body);
        return [
          22255.301999411342,
          22309.42522189943,
          22353.475855623805,
          22230.866395170393,
          22201.197608658433,
          22266.22066315609,
          22067.867506426574,
          22157.856424820675,
          22315.232713360027,
          22255.301999411342,
          22309.42522189943,
          22353.475855623805,
          22230.866395170393,
          22201.197608658433,
        ];
      }
    } catch (e) {
      log(e.toString());
      //log("loading -6- ");
      return [
        22255.301999411342,
        22309.42522189943,
        22353.475855623805,
        22230.866395170393,
        22201.197608658433,
        22266.22066315609,
        22067.867506426574,
        22157.856424820675,
        22315.232713360027,
        22255.301999411342,
        22309.42522189943,
        22353.475855623805,
        22230.866395170393,
        22201.197608658433,
      ];
    }
  }

  Future<List<Candle>> fetchCandles() async {
    final uri = Uri.parse(
        "https://api.binance.com/api/v3/klines?symbol=${binancePair.value}&interval=${binanceInterval.value}");
    final res = await http.get(uri);
    // log(res.body);

    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  setCandles() {
    fetchCandles().then((value) {
      chartsError.value = false;
      candles.value = value;
    }).catchError((e) {
      log("error thrown is $e");
      chartsError.value = true;
    });
  }

  @override
  void onReady() {
    getCoinPrices();
    setCandles();
    super.onReady();
  }
}
