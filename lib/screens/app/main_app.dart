import 'package:binance_cl/constants/assets_path.dart';
import 'package:binance_cl/screens/app/home/view/home.dart';
import 'package:binance_cl/screens/app/markets/view/markets.dart';
import 'package:binance_cl/screens/app/trade/view/trade.dart';
import 'package:binance_cl/screens/app/wallets/view/wallets.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  late Widget _currentPage;
  List<Widget> _pages = <Widget>[];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _currentPage = _pages[index];
    });
  }

  @override
  void initState() {
    _pages = <Widget>[
      HomeScreen(changePage: _onItemTapped),
      const Markets(),
      const TradeScreen(),
      const WalletsScreen(),
    ];
    _currentPage = HomeScreen(changePage: _onItemTapped);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: kBackgroundColor,
        // body: _pages.elementAt(_selectedIndex),
        body: _currentPage,
        bottomNavigationBar: SizedBox(
          height: heightSize(80),
          child: BottomNavigationBar(
            backgroundColor: kBackgroundColor,
            selectedItemColor: kPrimaryColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex, //New
            onTap: _onItemTapped,
            elevation: 0,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _selectedIndex == 0
                    ? SvgPicture.asset(home, color: kPrimaryColor, height: 35)
                    : SvgPicture.asset(home, color: kGreyColor, height: 35),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 1
                    ? SvgPicture.asset(markets,
                        color: kPrimaryColor, height: 35)
                    : SvgPicture.asset(markets, color: kGreyColor, height: 35),
                label: 'Markets',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 2
                    ? SvgPicture.asset(trade, color: kPrimaryColor, height: 35)
                    : SvgPicture.asset(trade, color: kGreyColor, height: 35),
                label: 'Trade',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 3
                    ? SvgPicture.asset(wallets,
                        color: kPrimaryColor, height: 35)
                    : SvgPicture.asset(wallets, color: kGreyColor, height: 35),
                label: 'Wallets',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
