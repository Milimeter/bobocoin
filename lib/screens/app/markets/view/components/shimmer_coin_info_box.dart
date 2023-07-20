import 'package:binance_cl/screens/app/markets/view/components/change_price_triangle.dart';
import 'package:binance_cl/screens/app/markets/view/components/sparkline_widget.dart'
    hide Trans;
import 'package:binance_cl/utils/sizes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCoinInfoBox extends StatelessWidget {
  const ShimmerCoinInfoBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: const Color(0xFFF7F7F7),
      baseColor: const Color(0xFF3D3C3A),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: widthSize(30),
                      height: heightSize(30),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: widthSize(8)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '----',
                          style: TextStyle(
                            fontSize: fontSize(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: heightSize(6)),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: widthSize(6)),
                              decoration: const BoxDecoration(
                                color: Color(0xFF3D3C3A),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                            SizedBox(width: widthSize(4)),
                            Text(
                              '---',
                              style: TextStyle(
                                fontSize: fontSize(11),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFA19999),
                              ),
                            ),
                            ChangePriceTriangle(
                              priceChangePercentage: 0,
                              fontSize: fontSize(18),
                              textStyle: TextStyle(
                                fontSize: fontSize(11),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFA19999),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: heightSize(40),
              child: const AbsorbPointer(
                absorbing: true,
                child: SparklineWidget(
                  sparkline: <double>[4, 1, 2, 10, 4, 12, 10],
                  flSpotList: <FlSpot>[
                    FlSpot(0, 4),
                    FlSpot(1, 1),
                    FlSpot(2, 2),
                    FlSpot(3, 10),
                    FlSpot(4, 4),
                    FlSpot(5, 12),
                    FlSpot(6, 10),
                  ],
                  showBarArea: false,
                  pricePercentage: 0,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '---',
                      style: TextStyle(
                        fontSize: fontSize(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: heightSize(6)),
                    Text(
                      '---- ----- --',
                      style: TextStyle(
                        fontSize: fontSize(11),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFA19999),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
