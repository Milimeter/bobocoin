import 'dart:math' as math;
import 'package:binance_cl/utils/colors.dart';
import 'package:flutter/material.dart';

class ChangePriceTriangle extends StatelessWidget {
  final double priceChangePercentage, fontSize;
  final TextStyle textStyle;

  const ChangePriceTriangle({
    Key? key,
    required this.priceChangePercentage,
    required this.fontSize,
    required this.textStyle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (priceChangePercentage > 0) {
      return Row(
        children: <Widget>[
          Container(
            transform: Matrix4.translationValues(0, 1.8, 0),
            child: Transform.rotate(
              angle: -90 * math.pi / 180,
              child: Icon(
                Icons.play_arrow,
                color: kUptrend2Color,
                size: fontSize,
              ),
            ),
          ),
          Text(
            '${priceChangePercentage.toStringAsFixed(2)}%',
            style: textStyle,
          ),
        ],
      );
    } else {
      if (priceChangePercentage < 0) {
        return Row(
          children: <Widget>[
            Container(
              transform: Matrix4.translationValues(0, -1, 0),
              child: Transform.rotate(
                angle: 90 * math.pi / 180,
                child: Icon(
                  Icons.play_arrow,
                  color: const Color(0xFFFF3B30),
                  size: fontSize,
                ),
              ),
            ),
            Text(
              '${priceChangePercentage.abs().toStringAsFixed(2)}%',
              style: textStyle,
            ),
          ],
        );
      } else {
        return Row(
          children: <Widget>[
            Container(
              transform: Matrix4.translationValues(0, -1, 0),
              child: Transform.rotate(
                angle: 90 * math.pi / 180,
                child: Icon(
                  Icons.play_arrow,
                  color: const Color(0xFFA19999),
                  size: fontSize,
                ),
              ),
            ),
            Text(
              '${priceChangePercentage.abs().toStringAsFixed(2)}%',
              style: textStyle,
            ),
          ],
        );
      }
    }
  }
}
