import 'package:binance_cl/screens/app/wallets/view/pages/overview/overview.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({Key? key}) : super(key: key);

  @override
  State<WalletsScreen> createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 1,
      initialIndex: 0,
    );
  }

  final _pages = [
    const Overview(),
    // const Spot(),
    // const Funding(),
    // const Margin(),
    // const Futures(),
    // Container(),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 1,
      child: SafeArea( 
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: kBackgroundColor,
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, heightSize(70)),
            child: TabBar(
              isScrollable: true,
              physics: const BouncingScrollPhysics(),
              controller: _tabController,
              labelColor: kPrimaryColor,
              indicatorColor: kPrimaryColor,
              unselectedLabelColor: kTextColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 1.75,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 28.0),
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
                  child: const Tab(
                    text: 'Overview',
                  ),
                ),
                // SizedBox(
                //   width: size.width * .15,
                //   child: const Tab(
                //     text: 'Spot',
                //   ),
                // ),
                // SizedBox(
                //   width: size.width * .15,
                //   child: const Tab(
                //     text: 'Funding',
                //   ),
                // ),
                // SizedBox(
                //   width: size.width * .15,
                //   child: const Tab(
                //     text: 'Margin',
                //   ),
                // ),
                // SizedBox(
                //   width: size.width * .15,
                //   child: const Tab(
                //     text: 'Futures',
                //   ),
                // ),
                // SizedBox(
                //   width: size.width * .15,
                //   child: const Tab(
                //     text: 'Earn',
                //   ),
                // ),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: _pages,
          ),
        ),
      ),
    );
  }
}
