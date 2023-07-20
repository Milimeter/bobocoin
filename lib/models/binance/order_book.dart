// To parse this JSON data, do
//
//     final orderBook = orderBookFromJson(jsonString);

import 'dart:convert';

OrderBook orderBookFromJson(String str) => OrderBook.fromJson(json.decode(str));

String orderBookToJson(OrderBook data) => json.encode(data.toJson());

class OrderBook {
    OrderBook({
        this.lastUpdateId,
        this.bids,
        this.asks,
    });

    int? lastUpdateId;
    List<List<String>>? bids;
    List<List<String>>? asks;

    factory OrderBook.fromJson(Map<String, dynamic> json) => OrderBook(
        lastUpdateId: json["lastUpdateId"],
        bids: List<List<String>>.from(json["bids"].map((x) => List<String>.from(x.map((x) => x)))),
        asks: List<List<String>>.from(json["asks"].map((x) => List<String>.from(x.map((x) => x)))),
    );

    Map<String, dynamic> toJson() => {
        "lastUpdateId": lastUpdateId,
        "bids": List<dynamic>.from(bids!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "asks": List<dynamic>.from(asks!.map((x) => List<dynamic>.from(x.map((x) => x)))),
    };
}
