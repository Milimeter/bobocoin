import 'dart:convert';
import 'dart:developer';

import 'package:binance_cl/constants/asset_balances.dart';
import 'package:binance_cl/constants/strings.dart';
import 'package:binance_cl/services/api_calls.dart';
import 'package:binance_cl/services/storage.dart';
import 'package:http/http.dart' as http;
import "package:get/get.dart";
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class BalanceController extends GetxController {
  // display the balances on the app effectively. no need to use local database.
  RxMap<String, dynamic> balances = {
    // "BNB": "0.0",
    // "BTC": "0.0",
    // "ETH": "0.0",
    // "ADA": "0.0",
    // "XRP": "0.0",
    // "DOGE": "0.0",
    // "TRX": "0.0",
    // "MATIC": "0.0",
    // "XLM": "0.0",
    // "BCH": "0.0",
    'AE': "0.0",
    'AION': "0.0",
    'BNB': "0.0",
    'BTC': "0.0",
    'BCH': "0.0",
    'BTG': "0.0",
    'CLO': "0.0",
    'ADA': "0.0",
    'ATOM': "0.0",
    'DASH': "0.0",
    'DCR': "0.0",
    'DGB': "0.0",
    'DOGE': "0.0",
    'EOS': "0.0",
    'ETH': "0.0",
    'ETC': "0.0",
    'FIO': "0.0",
    'GO': "0.0",
    'GRS': "0.0",
    'ICX': "0.0",
    'IOTX': "0.0",
    'KAVA': "0.0",
    'KIN': "0.0",
    'LTC': "0.0",
    'MONA': "0.0",
    'NAS': "0.0",
    'NULS': "0.0",
    'NXO': "0.0",
    'NEAR': "0.0",
    'NIM': "0.0",
    'ONT': "0.0",
    'POA': "0.0",
    'QTUM': "0.0",
    'XRP': "0.0",
    'SOL': "0.0",
    'XLM': "0.0",
    'XTZ': "0.0",
    'THETA': "0.0",
    'TT': "0.0",
    'NEO': "0.0",
    'TOMO': "0.0",
    'TRX': "0.0",
    'VET': "0.0",
    'VIA': "0.0",
    'WAN': "0.0",
    'ZEC': "0.0",
    'XZC': "0.0",
    'ZIL': "0.0",
    'ZEL': "0.0",
    'RVN': "0.0",
    'WAVES': "0.0",
    'LUNA': "0.0",
    'ONE': "0.0",
    'ALGO': "0.0",
    'KSM': "0.0",
    'DOT': "0.0",
    'FIL': "0.0",
    'ELGD': "0.0",
    'BAND': "0.0",
    'BSC': "0.0",
    'OASIS': "0.0",
    'MATIC': "0.0",
    'RUNE': "0.0",
    'BLZ': "0.0",
    'OP': "0.0",
    'ARB': "0.0",
    'ECOC': "0.0",
    'AVAX': "0.0",
    'XDAI': "0.0",
    'FTM': "0.0",
    'CELO': "0.0",
    'RON': "0.0",
    'OSMO': "0.0",
    'XEC': "0.0",
    'CRO': "0.0",
  }.obs;
  
  RxDouble equivalentBalance = RxDouble(0);
  String bscScanAPIKey = "IU1WNV3A6XIS356KU8N7K8QS7P8ADQ1KKX";
  String muuContractAddress = "0x2900e6b68658128784B9a1de242F811d938d8bA7";
  RxString muuWalletBalance = RxString('0');
  RxString error = RxString('');
  configureGetEquivalentBalanceRequest() async {
    double btcToUSDTAmount = 0.0;
    double ethToUSDTAmount = 0.0;
    double bnbToUSDTAmount = 0.0;
    double adaToUSDTAmount = 0.0;
    double dogeToUSDTAmount = 0.0;
    double trxToUSDTAmount = 0.0;
    double maticToUSDTAmount = 0.0;
    double xlmToUSDTAmount = 0.0;
    double bchToUSDTAmount = 0.0;
    double solToUSDTAmount = 0.0;
    double ltcToUSDTAmount = 0.0;
    double algoToUSDTAmount = 0.0;
    double oneToUSDTAmount = 0.0;

    try {
      for (var i in balances.keys) {
        if (i == "BTC") {
          log("BTC balance is ${balances["BTC"]}");
          if (double.parse(balances["BTC"]) != double.parse("0")) {
            btcToUSDTAmount = await getEquivalentBalance(
                amount: balances["BTC"], asset: "btc");
          }
        } else if (i == "ETH") {
          log("ETH balance is ${balances["ETH"]}");
          if (double.parse(balances["ETH"]) != double.parse("0")) {
            log("getting eth 1");
            ethToUSDTAmount = await getEquivalentBalance(
                amount: balances["ETH"], asset: "eth");
          }
        } else if (i == "BNB") {
          log("B NBbalance is ${balances["BNB"]}");
          if (double.parse(balances["BNB"]) != double.parse("0")) {
            log("getting BNB 1");
            bnbToUSDTAmount = await getEquivalentBalance(
                amount: balances["BNB"], asset: "bnb");
          }
        } else if (i == "ADA") {
          log("ADA balance is ${balances["ADA"]}");
          if (double.parse(balances["ADA"]) != double.parse("0")) {
            adaToUSDTAmount = await getEquivalentBalance(
                amount: balances["ADA"], asset: "ada");
          }
        } else if (i == "XRP") {
          log("XRP balance is ${balances["XRP"]}");
          if (double.parse(balances["XRP"]) != double.parse("0")) {
            dogeToUSDTAmount = await getEquivalentBalance(
                amount: balances["XRP"], asset: "xrp");
          }
        } else if (i == "DOGE") {
          log("DOGE balance is ${balances["DOGE"]}");
          if (double.parse(balances["DOGE"]) != double.parse("0")) {
            trxToUSDTAmount = await getEquivalentBalance(
                amount: balances["DOGE"], asset: "doge");
          }
        } else if (i == "TRX") {
          log("TRX balance is ${balances["TRX"]}");
          if (double.parse(balances["TRX"]) != double.parse("0")) {
            maticToUSDTAmount = await getEquivalentBalance(
                amount: balances["TRX"], asset: "trx");
          }
        } else if (i == "MATIC") {
          log("MATIC balance is ${balances["MATIC"]}");
          if (double.parse(balances["MATIC"]) != double.parse("0")) {
            xlmToUSDTAmount = await getEquivalentBalance(
                amount: balances["MATIC"], asset: "matic");
          }
        } else if (i == "XLM") {
          log("XLM balance is ${balances["XLM"]}");
          if (double.parse(balances["BTC"]) != double.parse("0")) {
            bchToUSDTAmount = await getEquivalentBalance(
                amount: balances["XLM"], asset: "xlm");
          }
        } else if (i == "SOL") {
          log("SOL balance is ${balances["SOL"]}");
          if (double.parse(balances["SOL"]) != double.parse("0")) {
            solToUSDTAmount = await getEquivalentBalance(
                amount: balances["SOL"], asset: "sol");
          }
        } else if (i == "LTC") {
          log("SOL balance is ${balances["LTC"]}");
          if (double.parse(balances["LTC"]) != double.parse("0")) {
            ltcToUSDTAmount = await getEquivalentBalance(
                amount: balances["LTC"], asset: "ltc");
          }
        } else if (i == "ALGO") {
          log("ALGO balance is ${balances["ALGO"]}");
          if (double.parse(balances["ALGO"]) != double.parse("0")) {
            ltcToUSDTAmount = await getEquivalentBalance(
                amount: balances["ALGO"], asset: "algo");
          }
        } else if (i == "ONE") {
          log("ONE balance is ${balances["ONE"]}");
          if (double.parse(balances["ONE"]) != double.parse("0")) {
            oneToUSDTAmount = await getEquivalentBalance(
                amount: balances["ONE"], asset: "one");
          }
        }
      }
      equivalentBalance.value = btcToUSDTAmount +
          ethToUSDTAmount +
          adaToUSDTAmount +
          dogeToUSDTAmount +
          bnbToUSDTAmount +
          trxToUSDTAmount +
          maticToUSDTAmount +
          xlmToUSDTAmount +
          bchToUSDTAmount +
          solToUSDTAmount +
          ltcToUSDTAmount +
          algoToUSDTAmount +
          oneToUSDTAmount;
      equivalentBalance.value =
          double.parse(equivalentBalance.value.toStringAsFixed(2));
      log("$btcToUSDTAmount + $bnbToUSDTAmount + $ethToUSDTAmount + $adaToUSDTAmount + $dogeToUSDTAmount + $trxToUSDTAmount + $maticToUSDTAmount + $xlmToUSDTAmount + $bchToUSDTAmount  + $solToUSDTAmount + $oneToUSDTAmount + $ltcToUSDTAmount + $algoToUSDTAmount");
    } catch (e) {
      log(e.toString());
    }
  }

  // getMuuWalletBalance() async {
  //   try {
  //     String mnemonics = await Storage.readData(WALLET_MNEMONICS);
  //     HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
  //     String walletAddress =
  //         wallet.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain);
  //     Uri url = Uri.parse(
  //         "https://api.bscscan.com/api?module=account&action=tokenbalance&contractaddress=$muuContractAddress&address=$walletAddress&tag=latest&apikey=$bscScanAPIKey");

  //     http.Response response = await http.get(url);
  //     var results = jsonDecode(response.body);
  //     log("_____BNB wallet $walletAddress");
  //     if (response.statusCode == 200) {
  //       BigInt result = BigInt.parse(results['result']);
  //       BigInt divisor = BigInt.parse("1000000000");
  //       double balance = (result / divisor).toDouble();
  //       log("Muu balance is: ${results['result']}");
  //       muuWalletBalance.value = balance.toStringAsFixed(2);
  //     } else {
  //       log(response.statusCode.toString());
  //       log("Unable to get Muu balance");
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  Future<double> getEquivalentBalance(
      {required String amount, required String asset}) async {
    try {
      String pair = "${asset}_usdt";
      Map req = await APICalls().getEstimatedExchangeAmount(pair, amount);
      log(req.toString());
      if (req.isNotEmpty) {
        if (req.containsKey("error")) {
          error.value = req['error'];
          return 0;
        } else {
          double estimatedAmount = req['estimatedAmount'];
          log("$asset equivalent amount is $estimatedAmount");
          return double.parse(estimatedAmount.toStringAsFixed(3));
        }
      } else {
        return 0;
      }
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }

  getBNBBalance() async {
    try {
      String mnemonics = await Storage.readData(WALLET_MNEMONICS);
      HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
      String walletAddress =
          wallet.getAddressForCoin(TWCoinType.TWCoinTypeSmartChain);
      log("_____BNB wallet $walletAddress");
      Uri url = Uri.parse(
          "https://api.bscscan.com/api?module=account&action=balance&address=$walletAddress&apikey=$bscScanAPIKey");
      http.Response response = await http.get(url);
      var results = jsonDecode(response.body);
      log(results.toString());
      if (results["message"] == "OK") {
        BigInt result = BigInt.parse(results['result']);
        BigInt divisor = BigInt.parse("1000000000000000000");
        double balance = (result / divisor).toDouble();
        balances['BNB'] = balance.toStringAsFixed(2);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  getBTCBalance() async {
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeBitcoin);
    log(walletAddress);
    //  String hh =
    //     wallet.getAddressForCoin(TWCoinType.TWCoinTypeBinance);
    // log("hh: $hh");
    Uri url = Uri.http(
      "api-us-west1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/bitcoin/address/balance/$walletAddress",
    );

    http.Response response = await http.get(url);
    var results = jsonDecode(response.body);
    log(results.toString());
    if (response.statusCode == 200) {
      log("Balance BTC: ${results['incoming']}");
      await Storage.saveData(AssetBalances.BTC, results['incoming']);
      balances['BTC'] = results['incoming'].toString();
    } else {
      log(response.statusCode.toString());
      log("Unable to get BTC balance");
    }
  }

  // getBNBBalance() async {
  //   String mnemonics = await Storage.readData(WALLET_MNEMONICS);
  //   HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
  //   String walletAddress =
  //       wallet.getAddressForCoin(TWCoinType.bin);
  //   log(walletAddress);
  //   Uri url = Uri.http(
  //     "api-us-west1.tatum.io", //https://pro-api.coinmarketcap.com
  //     "/v3/bitcoin/address/balance/$walletAddress",
  //   );

  //   http.Response response = await http.get(url);
  //   var results = jsonDecode(response.body);
  //   log(results.toString());
  //   if (response.statusCode == 200) {
  //     log("Balance BTC: ${results['incoming']}");
  //     await Storage.saveData(AssetBalances.BTC, results['incoming']);
  //     balances['BTC'] = results['incoming'].toString();
  //   } else {
  //     log(response.statusCode.toString());
  //     log("Unable to get BTC balance");
  //   }
  // }

  getETHBalance() async {
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeEthereum);
    log(walletAddress);
    Uri url = Uri.http(
      "api-us-west1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/ethereum/account/balance/$walletAddress",
    );

    http.Response response = await http.get(url);
    var results = jsonDecode(response.body);
    log(results.toString());
    if (response.statusCode == 200) {
      log("Balance ETH: ${results['balance']}");
      await Storage.saveData(AssetBalances.ETH, results['balance']);
      balances['ETH'] = results['balance'].toString();
    } else {
      log(response.statusCode.toString());
      log("Unable to get ETH balance");
    }
  }

  getADABalance() async {
    //*
    // String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    // HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    // String walletAddress =
    //     wallet.getAddressForCoin(TWCoinType.TWCoinTypeCardano);
    // log(walletAddress);

    // Uri uri = Uri.parse(
    //     'https://api-us-west1.tatum.io/v3/ada/account/$walletAddress');
    // Map<String, String> headers = {
    //   "Content-Type": "application/json",
    //   "x-api-key": "aaac02de-eb55-45d9-ac7a-807abf8e7adb_100"
    // };

    // http.Response response = await http.get(uri, headers: headers);
    // var results = jsonDecode(response.body);
    //   log("Ada balance data: $results");
    // if (response.statusCode == 200) {
    //   if (results["summary"]["assetBalances"].length > 0) {
    //     log("Balance ADA: ${results["summary"]["assetBalances"][0]["quantity"]}"); //${results[0]["summary"]["assetBalances"][0]["quantity"]}
    //     await Storage.saveData(AssetBalances.ADA,
    //         results['summary']['assetBalances'][0]['quantity']);
    //     balances['ADA'] =
    //         results['summary']['assetBalances'][0]['quantity'].toString();
    //   }
    //   log(results.toString());
    // } else {
    //   log(response.statusCode.toString());
    //   log("Unable to get ADA balance");
    // }
  }

  getXRPBalance() async {
    //*
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress = wallet.getAddressForCoin(TWCoinType.TWCoinTypeXRP);
    // Uri url = Uri.http(
    //   "api-us-west1.tatum.io", //https://pro-api.coinmarketcap.com
    //   "/v3/xrp/account/$walletAddress/balance",
    // );
    //https://api-us-west1.tatum.io/v3/xrp/account/{account}/balance
    Uri uri = Uri.parse(
        'https://api-us-west1.tatum.io/v3/xrp/account/$walletAddress/balance');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "x-api-key": "aaac02de-eb55-45d9-ac7a-807abf8e7adb_100"
    };
    log("XRP   $walletAddress");
    http.Response response = await http.get(uri, headers: headers);
    var results = jsonDecode(response.body);
    log(results.toString());
    if (response.statusCode == 200) {
      log("Balance XRP: ${results['balance']}");
      await Storage.saveData(AssetBalances.XRP, results['balance']);
      balances['XRP'] = results['balance'].toString();
    } else {
      log(response.statusCode.toString());
      log("Unable to get XRP balance");
    }
  }

  getDOGEBalance() async {
    //*
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeDogecoin);
    log(walletAddress);
    Uri url = Uri.parse(
        "https://dogechain.info/api/v1/address/balance/$walletAddress");

    http.Response response = await http.get(url);
    var results = jsonDecode(response.body);
    log(results.toString());
    if (response.statusCode == 200) {
      if (results["success"] == 1) {
        String balance = double.parse(results["balance"]).toStringAsFixed(2);
        log("dogeBalance: $balance");
        await Storage.saveData(AssetBalances.DOGE, balance);
        balances['DOGE'] = balance;
      }
    } else {
      log(response.statusCode.toString());
      log("Unable to get DOGE balance");
    }
  }

  getTRONBalance() async {
    //*
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress = wallet.getAddressForCoin(TWCoinType.TWCoinTypeTron);
    Uri uri = Uri.parse(
        'https://api-us-west1.tatum.io/v3/tron/account/$walletAddress');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "x-api-key": "aaac02de-eb55-45d9-ac7a-807abf8e7adb_100"
    };
    log(walletAddress);
    http.Response response = await http.get(uri, headers: headers);
    var results = jsonDecode(response.body);
    log(results.toString());
    if (response.statusCode == 200) {
      double balance = results['balance'] / 1000000;
      log("Balance TRX: ${results['balance']}--------$balance");

      await Storage.saveData(AssetBalances.TRON,
          double.parse(balance.toStringAsFixed(3)).toString());
      balances['TRX'] = double.parse(balance.toStringAsFixed(3)).toString();
    } else {
      log(response.statusCode.toString());
      log("Unable to get TRX balance");
    }
  }

  getMATICBalance() async {
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypePolygon);
    Uri uri = Uri.parse(
        'https://api-us-west1.tatum.io/v3/polygon/account/balance/$walletAddress');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "x-api-key": "aaac02de-eb55-45d9-ac7a-807abf8e7adb_100"
    };
    log(walletAddress);
    http.Response response = await http.get(uri, headers: headers);
    var results = jsonDecode(response.body);
    log(results.toString());
    if (response.statusCode == 200) {
      log("Balance MATIC: ${results['balance']}");
      await Storage.saveData(AssetBalances.MATIC, results['balance']);
      balances['MATIC'] = results['balance'].toString();
    } else {
      log(response.statusCode.toString());
      log("Unable to get MATIC balance");
    }
  }

  getXLMBalance() async {
    //*
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeStellar);
    log(walletAddress);
    Uri uri = Uri.parse(
        'https://api-us-west1.tatum.io/v3/xlm/account/$walletAddress');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "x-api-key": "aaac02de-eb55-45d9-ac7a-807abf8e7adb_100"
    };
    log(walletAddress);
    http.Response response = await http.get(uri, headers: headers);
    var results = jsonDecode(response.body);
    log(results.toString());
    if (response.statusCode == 200) {
      log("Balance XLM: ${results['balances'][0]['balance']}");
      await Storage.saveData(
          AssetBalances.XLM, results['balances'][0]['balance']);
      balances['XLM'] = results['balances'][0]['balance'].toString();
    } else {
      log(response.statusCode.toString());
      log("Unable to get XLM balance");
    }
  }

  getBCHBalance() async {
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeBitcoinCash);
    Uri uri = Uri.parse(
        'https://api-us-west1.tatum.io/v3/xlm/account/$walletAddress');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "x-api-key": "aaac02de-eb55-45d9-ac7a-807abf8e7adb_100"
    };
    log(walletAddress);
    http.Response response = await http.get(uri, headers: headers);

    var results = jsonDecode(response.body);
    log(results.toString());
    if (response.statusCode == 200) {
      log("Balance BCH: ${results['balance']}");
      await Storage.saveData(AssetBalances.BCH, results['balance']);
      balances['BCH'] = results['balance'].toString();
    } else {
      log(response.statusCode.toString());
      log("Unable to get BCH balance");
    }
  }

  getSOLBalance() async {
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeSolana);
    Uri uri = Uri.parse(
        'https://api-us-west1.tatum.io/v3/solana/account/$walletAddress');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "x-api-key": "aaac02de-eb55-45d9-ac7a-807abf8e7adb_100"
    };
    log(walletAddress);
    http.Response response = await http.get(uri, headers: headers);

    var results = jsonDecode(response.body);
    log(results.toString());
    if (response.statusCode == 200) {
      log("Balance SOL: ${results['balance']}");
      await Storage.saveData(AssetBalances.SOL, results['balance']);
      balances['SOL'] = results['balance'].toString();
    } else {
      log(response.statusCode.toString());
      log("Unable to get SOL balance");
    }
  }

  getLTCBalance() async {
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeLitecoin);
    Uri uri = Uri.parse(
        'https://api-us-west1.tatum.io/v3/litecoin/address/balance/$walletAddress');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "x-api-key": "aaac02de-eb55-45d9-ac7a-807abf8e7adb_100"
    };
    log(walletAddress);
    http.Response response = await http.get(uri, headers: headers);

    var results = jsonDecode(response.body);
    log(results.toString());
    if (response.statusCode == 200) {
      log("Balance LTC: ${results['incoming']}");
      await Storage.saveData(AssetBalances.LTC, results['incoming']);
      balances['LTC'] = results['incoming'].toString();
    } else {
      log(response.statusCode.toString());
      log("Unable to get LTC balance");
    }
  }

  getALGOBalance() async {
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeAlgorand);
    Uri uri = Uri.parse(
        'https://api-us-west1.tatum.io/v3/algorand/account/balance/$walletAddress');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "x-api-key": "aaac02de-eb55-45d9-ac7a-807abf8e7adb_100"
    };
    log(walletAddress);
    http.Response response = await http.get(uri, headers: headers);

    var results = jsonDecode(response.body);
    log(results.toString());
    if (response.statusCode == 200) {
      log("Balance ALGO: ${results['balance']}");
      await Storage.saveData(AssetBalances.ALGO, results['balance'].toString());
      balances['ALGO'] = results['balance'].toString();
    } else {
      log(response.statusCode.toString());
      log("Unable to get ALGO balance");
    }
  }

  getONEBalance() async {
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeHarmony);
    Uri uri = Uri.parse(
        'https://api-us-west1.tatum.io/v3/one/account/balance/$walletAddress');
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "x-api-key": "aaac02de-eb55-45d9-ac7a-807abf8e7adb_100"
    };
    log(walletAddress);
    http.Response response = await http.get(uri, headers: headers);

    var results = jsonDecode(response.body);
    log(results.toString());
    if (response.statusCode == 200) {
      log("Balance ONE: ${results['balance']}");
      await Storage.saveData(AssetBalances.ONE, results['balance']);
      balances['ONE'] = results['balance'].toString();
    } else {
      log(response.statusCode.toString());
      log("Unable to get ONE balance");
    }
  }

  getBalances() {
    getBNBBalance();
    getBTCBalance();
    getETHBalance();
    getADABalance();
    getXRPBalance();
    getDOGEBalance();
    getTRONBalance();
    getMATICBalance();
    getXLMBalance();
    getSOLBalance();
    getALGOBalance();
    getONEBalance();
    // getBCHBalance(); //remove
  }

  @override
  void onReady() {
    getBalances();
    super.onReady();
  }
}
