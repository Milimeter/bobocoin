// To parse this JSON data, do
//
//     final cryptoPriceChangeStatistics = cryptoPriceChangeStatisticsFromJson(jsonString);

import 'dart:convert';

List<CryptoPriceChangeStatistics> cryptoPriceChangeStatisticsFromJson(String str) => List<CryptoPriceChangeStatistics>.from(json.decode(str).map((x) => CryptoPriceChangeStatistics.fromJson(x)));

String cryptoPriceChangeStatisticsToJson(List<CryptoPriceChangeStatistics> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CryptoPriceChangeStatistics {
    CryptoPriceChangeStatistics({
        this.symbol,
        this.priceChange,
        this.priceChangePercent,
        this.weightedAvgPrice,
        this.openPrice,
        this.highPrice,
        this.lowPrice,
        this.lastPrice,
        this.volume,
        this.quoteVolume,
        this.openTime,
        this.closeTime,
        this.firstId,
        this.lastId,
        this.count,
    });

    String? symbol;
    String? priceChange;
    String? priceChangePercent;
    String? weightedAvgPrice;
    String? openPrice;
    String? highPrice;
    String? lowPrice;
    String? lastPrice;
    String? volume;
    String? quoteVolume;
    int? openTime;
    int? closeTime;
    int? firstId;
    int? lastId;
    int? count;

    factory CryptoPriceChangeStatistics.fromJson(Map<String, dynamic> json) => CryptoPriceChangeStatistics(
        symbol: json["symbol"],
        priceChange: json["priceChange"],
        priceChangePercent: json["priceChangePercent"],
        weightedAvgPrice: json["weightedAvgPrice"],
        openPrice: json["openPrice"],
        highPrice: json["highPrice"],
        lowPrice: json["lowPrice"],
        lastPrice: json["lastPrice"],
        volume: json["volume"],
        quoteVolume: json["quoteVolume"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        firstId: json["firstId"],
        lastId: json["lastId"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "priceChange": priceChange,
        "priceChangePercent": priceChangePercent,
        "weightedAvgPrice": weightedAvgPrice,
        "openPrice": openPrice,
        "highPrice": highPrice,
        "lowPrice": lowPrice,
        "lastPrice": lastPrice,
        "volume": volume,
        "quoteVolume": quoteVolume,
        "openTime": openTime,
        "closeTime": closeTime,
        "firstId": firstId,
        "lastId": lastId,
        "count": count,
    };
}
