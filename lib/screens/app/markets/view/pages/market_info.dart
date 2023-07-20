import 'package:binance_cl/screens/app/markets/view/components/chart_interval.dart';
import 'package:binance_cl/screens/app/markets/view/components/coin_chart.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:text_scroll/text_scroll.dart';

import '../components/coin_chart_info.dart';
import '../components/top_action.dart';

class MarketInfo extends StatefulWidget {
  const MarketInfo({Key? key}) : super(key: key);

  @override
  State<MarketInfo> createState() => _MarketInfoState();
}

class _MarketInfoState extends State<MarketInfo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 4,
      initialIndex: 0,
    );
  }

  final _pages = [
    Container(),
    Container(),
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: constraints.maxHeight * 0.02),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: TopAction(),
                ),
                SizedBox(height: heightSize(20)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      const Icon(
                        Entypo.megaphone,
                        color: kPrimaryColor,
                        size: 30,
                      ),
                      SizedBox(width: widthSize(10)),
                      Expanded(
                        child: TextScroll(
                            'mkinfo'.tr(),
                            style: TextStyle(
                              fontSize: fontSize(16),
                              fontWeight: FontWeight.w400,
                              color: kPrimaryColor, //Colors.grey

                              letterSpacing: 0,
                              height: 1,
                            )),
                      ),
                      SizedBox(width: widthSize(7)),
                    ],
                  ),
                ),
                SizedBox(height: heightSize(10)),
                const CoinMarketInfo(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        //SizedBox(height: heightSize(30)),
                        ChartInterval(
                          height: constraints.maxHeight * 0.06,
                          width: constraints.maxWidth,
                        ),
                        SizedBox(height: heightSize(10)),
                        CoinChart(
                          height: constraints.maxHeight * 0.50,
                          width: constraints.maxWidth,
                        ),
                        SizedBox(height: heightSize(20)),
                        PreferredSize(
                          preferredSize: Size(double.infinity, heightSize(70)),
                          child: TabBar(
                            isScrollable: true,
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            physics: const BouncingScrollPhysics(),
                            controller: _tabController,
                            labelColor: kPrimaryColor,
                            indicatorColor: kPrimaryColor,
                            unselectedLabelColor: kTextColor,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorWeight: 1.75,
                            indicatorPadding:
                                const EdgeInsets.symmetric(horizontal: 28.0),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: size.width / fontSize(28.0),
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: size.width / fontSize(32),
                            ),
                            tabs: [
                              SizedBox(
                                width: size.width * .15,
                                child:  Tab(
                                  text: 'ordbok'.tr(),
                                ),
                              ),
                              SizedBox(
                                width: size.width * .15,
                                child:  Tab(
                                  text: 'trds'.tr(),
                                ),
                              ),
                              SizedBox(
                                width: size.width * .15,
                                child:  Tab(
                                  text: 'oidata'.tr(),
                                ),
                              ),
                              SizedBox(
                                width: size.width * .15,
                                child:  Tab(
                                  text: 'conrt'.tr(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.5,
                          child: TabBarView(
                            physics: const BouncingScrollPhysics(),
                            controller: _tabController,
                            children: <Widget>[
                              Container(),
                              Container(),
                              Container(),
                              Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
