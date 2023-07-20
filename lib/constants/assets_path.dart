const String imageAssetRoot = "assets/";

//svg assets
// final String facebook = _getImagePath("svg/facebook.svg");
final String home = _getImagePath("svg/home.svg");
final String markets = _getImagePath("svg/market.svg");
final String trade = _getImagePath("svg/trade.svg");
final String wallets = _getImagePath("svg/wallet.svg");
final String profile = _getImagePath("svg/profile.svg");
final String lens = _getImagePath("svg/lens.svg");
final String bell = _getImagePath("svg/bell.svg");
final String scan = _getImagePath("svg/scan.svg");
final String referral = _getImagePath("svg/referral.svg");


//png assetsPath
final String btc = _getImagePath("png/btc.png");
final String logo = _getImagePath("png/logo.png");
final String captcha = _getImagePath("png/captcha.jpeg");
final String ads = _getImagePath("png/ads.png");
final String translate = _getImagePath("png/translate.png");


String _getImagePath(String imageName) => imageAssetRoot + imageName;
