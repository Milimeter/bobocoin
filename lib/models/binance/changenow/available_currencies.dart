// To parse this JSON data, do
//
//     final changeNowAvailableCurrencies = changeNowAvailableCurrenciesFromJson(jsonString);

import 'dart:convert';

List<ChangeNowAvailableCurrencies> changeNowAvailableCurrenciesFromJson(String str) => List<ChangeNowAvailableCurrencies>.from(json.decode(str).map((x) => ChangeNowAvailableCurrencies.fromJson(x)));

String changeNowAvailableCurrenciesToJson(List<ChangeNowAvailableCurrencies> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChangeNowAvailableCurrencies {
    ChangeNowAvailableCurrencies({
        this.ticker,
        this.name,
        this.image,
        this.hasExternalId,
        this.isFiat,
        this.featured,
        this.isStable,
        this.supportsFixedRate,
    });

    String? ticker;
    String? name;
    String? image;
    bool? hasExternalId;
    bool? isFiat;
    bool? featured;
    bool? isStable;
    bool? supportsFixedRate;

    factory ChangeNowAvailableCurrencies.fromJson(Map<String, dynamic> json) => ChangeNowAvailableCurrencies(
        ticker: json["ticker"],
        name: json["name"],
        image: json["image"],
        hasExternalId: json["hasExternalId"],
        isFiat: json["isFiat"],
        featured: json["featured"],
        isStable: json["isStable"],
        supportsFixedRate: json["supportsFixedRate"],
    );

    Map<String, dynamic> toJson() => {
        "ticker": ticker,
        "name": name,
        "image": image,
        "hasExternalId": hasExternalId,
        "isFiat": isFiat,
        "featured": featured,
        "isStable": isStable,
        "supportsFixedRate": supportsFixedRate,
    };
}
