import 'package:binance_cl/constants/assets_path.dart';
import 'package:binance_cl/shared/search_container.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopAction extends StatelessWidget {
  const TopAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightSize(45),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: SearchContainer(
              width: double.infinity,
              height: heightSize(45),
              text: "Search coin markets",
              callback: () {},
            ),
          ),
          SizedBox(width: widthSize(10)),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              scan,
              color: kGreyColor,
              height: 35,
            ),
          ),
          SizedBox(width: widthSize(10)),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              bell,
              color: kGreyColor,
              height: 35,
            ),
          ),
        ],
      ),
    );
  }
}
