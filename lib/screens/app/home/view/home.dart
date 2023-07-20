import 'package:binance_cl/constants/assets_path.dart';
import 'package:binance_cl/screens/app/home/controller/home_controller.dart';
import 'package:binance_cl/screens/app/home/view/components/multi_action_container.dart';
import 'package:binance_cl/screens/app/home/view/components/p2p_container.dart';
import 'package:binance_cl/screens/app/home/view/components/price_change_list.dart';
import 'package:binance_cl/screens/app/home/view/components/top_action.dart';
import 'package:binance_cl/screens/app/home/view/modals/drawer.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart' hide Trans;
import 'package:text_scroll/text_scroll.dart';

import 'components/3_coin_data.dart';

class HomeScreen extends StatefulWidget {
  final void Function(int) changePage;
  const HomeScreen({Key? key, required this.changePage}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CarouselController _controller = CarouselController();
  HomeController authController = Get.find();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: kBackgroundColor,
        drawer: const HomeDrawer(),
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: constraints.maxHeight * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: TopAction(
                    drawerKey: _scaffoldKey,
                  ),
                ),
                SizedBox(height: heightSize(20)),
                Expanded(
                    child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: SizedBox(
                          height: heightSize(180),
                          child: CarouselSlider(
                            carouselController: _controller,
                            options: CarouselOptions(
                                scrollPhysics: const BouncingScrollPhysics(),
                                enableInfiniteScroll: true,
                                enlargeCenterPage: true,
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 600),
                                height: 400.0,
                                autoPlay: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                            items: [ads, ads, ads, ads, ads].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                      image: AssetImage(i),
                                      fit: BoxFit.cover,
                                    )),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ads, ads, ads, ads, ads]
                            .asMap()
                            .entries
                            .map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black)
                                      .withOpacity(
                                          _current == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
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
                            // const Expanded(
                            //   child: CText(
                            //     text:
                            //         "Share your Ads to get exclusive trades. Well to ...",
                            //     allowOverflow: true,
                            //   ),
                            // ),
                            Expanded(
                              child: TextScroll(
                                  'scroll_msg'.tr(),
                                  style: TextStyle(
                                    fontSize: fontSize(16),
                                    fontWeight: FontWeight.w400,
                                    color: kWhiteColor, //Colors.grey
                                    letterSpacing: 0,
                                    height: 1,
                                  )),
                            ),
                            SizedBox(width: widthSize(20)),
                            const Icon(
                              Entypo.sound_mix,
                              color: kPrimaryColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: heightSize(10)), 
                      MultiActionContainer(changePage: widget.changePage),
                      SizedBox(height: heightSize(10)),
                      const P2PContainer(),
                      SizedBox(height: heightSize(10)),
                      const ThreeCoinData(),
                      SizedBox(height: heightSize(10)),
                      const PriceChangeList(),
                    ],
                  ),
                ))
              ],
            );
          }),
        ));
  }
}
