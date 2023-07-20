import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SpotOrders extends StatefulWidget {
  const SpotOrders({Key? key}) : super(key: key);

  @override
  State<SpotOrders> createState() => _SpotOrdersState();
}

class _SpotOrdersState extends State<SpotOrders> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: heightSize(500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              CText(
                text: "Orders",
                color: kWhiteColor,
              ),
              Spacer(),
              Icon(
                Entypo.text_document,
                size: 18,
              ),
              CText(
                text: "All Orders",
                color: kWhiteColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
