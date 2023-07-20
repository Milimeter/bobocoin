import 'dart:math';

import 'package:binance_cl/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';



class SparklineWidget extends StatefulWidget {
  final List<double>? sparkline;
  final List<FlSpot>? flSpotList;
  final bool showBarArea;
  final num pricePercentage;

  const SparklineWidget({
    required this.sparkline,
    required this.flSpotList,
    required this.showBarArea,
    required this.pricePercentage,
    Key? key,
  }) : super(key: key);

   @override
  State<SparklineWidget> createState() => _SparklineWidgetState();
}

class _SparklineWidgetState extends State<SparklineWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: LineChart(
            mainData(),
            swapAnimationCurve: Curves.linear,
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    // final List<Color> gradientColors = <Color>[
    //   if (widget.pricePercentage >= 0)
    //     const Color(0xFF6BD1E7)
    //   else
    //     const Color(0xFFFF3B30),
    //   if (widget.pricePercentage >= 0)
    //     kPrimaryColor
    //   else
    //     const Color(0xFFFF6057),
    // ];
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (double value) {
          return FlLine(
            color: widget.pricePercentage >= 0
                ? const Color(0xff37434d)
                : const Color(0xff4D3737),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (double value) {
          return FlLine(
            color: widget.pricePercentage >= 0
                ? const Color(0xff37434d)
                : const Color(0xff4D3737),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: false,
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(
              color: widget.pricePercentage >= 0
                  ? const Color(0xff37434d)
                  : const Color(0xff4D3737),
              width: 1)),
      minX: 0,
      maxX: widget.sparkline?.length.toDouble(),
      minY: widget.sparkline?.reduce(min),
      maxY: widget.sparkline?.reduce(max),
      lineBarsData: <LineChartBarData>[
        LineChartBarData(
          spots: widget.flSpotList,
          isCurved: true,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              if (widget.pricePercentage >= 0)
                const Color(0xFF6BD1E7)
              else
                const Color(0xFFFF3B30),
              if (widget.pricePercentage >= 0)
                kPrimaryColor
              else
                const Color(0xFFFF6057),
            ],
          ),
          barWidth: 1,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: widget.showBarArea,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                if (widget.pricePercentage >= 0)
                  const Color(0xFF6BD1E7)
                else
                  const Color(0xFFFF3B30),
                if (widget.pricePercentage >= 0)
                  kPrimaryColor
                else
                  const Color(0xFFFF6057),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
