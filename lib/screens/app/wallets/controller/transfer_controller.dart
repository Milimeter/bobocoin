import 'dart:convert';
import 'dart:developer';

import 'package:binance_cl/constants/private_keys_strings.dart';
import 'package:binance_cl/constants/strings.dart';
import 'package:binance_cl/shared/custom_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

import '../../../../services/storage.dart';

class TransferController extends GetxController {
  RxString selectedSendAssetName = RxString('');
  RxString selectedSendAssetSymbol = RxString('');
  RxString selectedSendAssetBalance = RxString('');
  RxString selectedSendAssetPrice = RxString('');
  RxString selectedSendAssetLogo = RxString('');
  RxString selectedReceiveWalletAddress = RxString('');
  RxBool load = RxBool(false);

  callSendAssets({
    required String symbol,
    required String address,
    required double amount,
  }) {
    log("crypto asset symbol is : $symbol");
    switch (symbol) {
      case "BTC":
        sendBtc(address: address, amount: amount);
        break;
      case "ETH":
        sendEth(address: address, amount: amount);
        break;
      case "BNB":
        sendBNB(address: address, amount: amount);
        break;
      case "ADA":
        sendADA(address: address, amount: amount);
        break;
      case "XRP":
        sendXRP(address: address, amount: amount);
        break;
      case "TRX":
        sendTRX(address: address, amount: amount);
        break;
      case "BCH":
        sendBCH(address: address, amount: amount);
        break;
      //DOGE
      case "MATIC":
        sendMATIC(address: address, amount: amount);
        break;
      case "XLM":
        sendXLM(address: address, amount: amount);
        break;
      default:
        load.value = false;
        cToast(
            title: "Notice", message: "Unable to send $symbol at the moment");
    }
  }

  ///Sending BTC
  sendBtc({required String address, required double amount}) async {
    load.value = true;
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeBitcoin);
    log(walletAddress);
    String? privateKey;
    send() async {
      load.value = true;
      log("sending BTC...");
      Uri uri =
          Uri.parse('https://api-us-west1.tatum.io/v3/bitcoin/transaction');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map<String, dynamic> body = {
        'fromAddress': [
          {"address": walletAddress, "privateKey": privateKey}
        ],
        'to': [
          {
            "address": address,
            "value": amount,
          }
        ]
      };

      log(body.toString());

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        if (results.containsKey("txId")) {
          load.value = false;
          // Get.toNamed(
          //   Routes.SEND_SUCCESS,
          //   arguments: {
          //     "amount": "$amount",
          //     "walletAddress": walletAddress,
          //   },
          // );
        }
      } else {
        load.value = false;
        cToast(title: "Notice", message: results['data'].toString());
        load.value = false;
        log(response.statusCode.toString());
        log(response.body.toString());
        //sent = false;
        log(results['message'].toString());
      }
    }

    getPrivateKey() async {
      load.value = true;
      log("Getting BTC private key..");
      Uri uri =
          Uri.parse('https://api-us-west1.tatum.io/v3/bitcoin/wallet/priv');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map<String, dynamic> body = {
        'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
        'mnemonic': mnemonics
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      log("----------________-------");
      log(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        privateKey = results['key'];
        await Storage.saveData(PrivateKeys.BTC, results['key']);
      } else {
        log(response.statusCode.toString());
        log(response.body.toString());
      }
    }

    privateKey = await Storage.readData(PrivateKeys.BTC);
    if (privateKey == null) {
      getPrivateKey().then((_) {
        return send();
      });
    } else {
      send();
    }
  }

  ///Sending ETH
  sendEth({required String address, required double amount}) async {
    load.value = true;
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeEthereum);
    log(walletAddress);
    String? privateKey;
    send() async {
      load.value = true;
      Uri uri =
          Uri.parse('https://api-us-west1.tatum.io/v3/ethereum/transaction');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map body = {
        'to': address, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
        'currency': 'ETH',
        'amount': amount,
        'fromPrivateKey': privateKey
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        if (results.containsKey("txId")) {
          // Get.toNamed(
          //   Routes.SEND_SUCCESS,
          //   arguments: {
          //     "amount": "$amount",
          //     "walletAddress": walletAddress,
          //   },
          // );
        }
      } else {
        load.value = false;
        cToast(title: "Notice", message: results['data'].toString());
        log(response.statusCode.toString());
        log(response.body.toString());
        //sent = false;
        log(results['message']);
        load.value = false;
      }
    }

    getPrivateKey() async {
      load.value = true;
      Uri uri =
          Uri.parse('https://api-us-west1.tatum.io/v3/ethereum/wallet/priv');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map<String, dynamic> body = {
        'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
        'mnemonic': mnemonics
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        privateKey = results['key'];
        await Storage.saveData(PrivateKeys.ETH, results['key']);
        load.value = false;
      } else {
        log(response.statusCode.toString());
        log(response.body.toString());
        load.value = false;
      }
    }

    privateKey = await Storage.readData(PrivateKeys.ETH);
    if (privateKey == null) {
      getPrivateKey().then((value) {
        return send();
      });
    } else {
      send();
    }
  }

  ///Sending ETH
  sendBNB({required String address, required double amount}) async {
    load.value = true;
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeEthereum);
    log(walletAddress);
    String? privateKey;
    send() async {
      load.value = true;
      Uri uri = Uri.parse('https://api-us-west1.tatum.io/v3/bsc/transaction');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map body = {
        'to': address, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
        'currency': 'BSC',
        'amount': "$amount",
        'fromPrivateKey': privateKey
      };
      log("body data: $body");
      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        if (results.containsKey("txId")) {
          // Get.toNamed(
          //   Routes.SEND_SUCCESS,
          //   arguments: {
          //     "amount": "$amount",
          //     "walletAddress": walletAddress,
          //   },
          // );
        }
      } else {
        load.value = false;
        cToast(title: "Notice", message: results['data'].toString());
        log(response.statusCode.toString());
        log(response.body.toString());
        //sent = false;
        log(results['message']);
        load.value = false;
      }
    }

    getPrivateKey() async {
      load.value = true;
      Uri uri = Uri.parse('https://api-us-west1.tatum.io/v3/bsc/wallet/priv');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map<String, dynamic> body = {
        'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
        'mnemonic': mnemonics
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        privateKey = results['key'];
        await Storage.saveData(PrivateKeys.BNB, results['key']);
        load.value = false;
      } else {
        log(response.statusCode.toString());
        log(response.body.toString());
        load.value = false;
      }
    }

    privateKey = await Storage.readData(PrivateKeys.BNB);
    if (privateKey == null) {
      getPrivateKey().then((value) {
        return send();
      });
    } else {
      send();
    }
  }

  ///Sending ADA
  sendADA({required String address, required double amount}) async {
    load.value = true;
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeCardano);
    log(walletAddress);
    String? privateKey;
    send() async {
      load.value = true;
      Uri uri = Uri.parse('https://api-us-west1.tatum.io/v3/ada/transaction');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map body = {
        "changeAddress": walletAddress,
        "fee": "0.5",
        "fromAddress": [
          {"address": walletAddress, "privateKey": privateKey}
        ],
        "to": [
          {"address": address, "value": amount}
        ]
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        if (results.containsKey("txId")) {
          // Get.toNamed(
          //   Routes.SEND_SUCCESS,
          //   arguments: {
          //     "amount": "$amount",
          //     "walletAddress": walletAddress,
          //   },
          // );
        }
      } else {
        load.value = false;
        cToast(title: "Notice", message: results['data'].toString());
        log(response.statusCode.toString());
        log(response.body.toString());
        //sent = false;
        log(results['message']);
        load.value = false;
      }
    }

    getPrivateKey() async {
      load.value = true;
      Uri uri = Uri.parse('https://api-us-west1.tatum.io/v3/ada/wallet/priv');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map<String, dynamic> body = {
        'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
        'mnemonic': mnemonics
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        privateKey = results['key'];
        await Storage.saveData(PrivateKeys.ADA, results['key']);
      } else {
        log(response.statusCode.toString());
        log(response.body.toString());
      }
    }

    privateKey = await Storage.readData(PrivateKeys.ADA);
    if (privateKey == null) {
      getPrivateKey().then((value) {
        return send();
      });
    } else {
      send();
    }
  }

  ///Sending XRP
  sendXRP({required String address, required double amount}) async {
    load.value = true;
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress = wallet.getAddressForCoin(TWCoinType.TWCoinTypeXRP);
    log(walletAddress);
    String? privateKey;
    send() async {
      load.value = true;
      Uri uri = Uri.parse('https://api-us-west1.tatum.io/v3/ada/transaction');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map body = {
        "fromAccount": walletAddress,
        "to": address,
        "amount": amount,
        "fromSecret": privateKey,
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        if (results.containsKey("txId")) {
          // Get.toNamed(
          //   Routes.SEND_SUCCESS,
          //   arguments: {
          //     "amount": "$amount",
          //     "walletAddress": walletAddress,
          //   },
          // );
        }
      } else {
        load.value = false;
        cToast(title: "Notice", message: results['data'].toString());
        log(response.statusCode.toString());
        log(response.body.toString());
        //sent = false;
        log(results['message']);
        load.value = false;
      }
    }

    getPrivateKey() async {
      load.value = true;
      Uri uri = Uri.parse('https://api-us-west1.tatum.io/v3/xrp/wallet/priv');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map<String, dynamic> body = {
        'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
        'mnemonic': mnemonics
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        privateKey = results['key'];
        await Storage.saveData(PrivateKeys.XRP, results['key']);
      } else {
        log(response.statusCode.toString());
        log(response.body.toString());
      }
    }

    privateKey = await Storage.readData(PrivateKeys.XRP);
    if (privateKey == null) {
      getPrivateKey().then((value) {
        return send();
      });
    } else {
      send();
    }
  }

  ///Sending XRP
  sendTRX({required String address, required double amount}) async {
    log("sending trx");
    load.value = true;
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress = wallet.getAddressForCoin(TWCoinType.TWCoinTypeTron);
    log(walletAddress);
    String? privateKey;
    send() async {
      load.value = true;
      Uri uri =
          Uri.parse('https://api-us-west1.tatum.io/v3/tron/trc20/transaction');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map body = {
        "fromPrivateKey": privateKey,
        "to": address,
        "tokenAddress": walletAddress,
        "feeLimit": 0.01,
        "amount": "$amount"
      };
      log("body data: $body");

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      log(results.toString());
      if (response.statusCode == 200) {
        load.value = false;
        if (results.containsKey("txId")) {
          // Get.toNamed(
          //   Routes.SEND_SUCCESS,
          //   arguments: {
          //     "amount": "$amount",
          //     "walletAddress": walletAddress,
          //   },
          // );
        }
      } else {
        load.value = false;
        cToast(title: "Notice", message: results['data'].toString());
        log(response.statusCode.toString());
        log(response.body.toString());
        //sent = false;
        log(results['message']);
        load.value = false;
      }
    }

    getPrivateKey() async {
      load.value = true;
      Uri uri = Uri.parse('https://api-us-west1.tatum.io/v3/tron/wallet/priv');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map<String, dynamic> body = {
        'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
        'mnemonic': mnemonics
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      log(results.toString());
      if (response.statusCode == 201) {
        load.value = false;
        privateKey = results['key'];
        await Storage.saveData(PrivateKeys.TRON, results['key']);
      } else {
        log(response.statusCode.toString());
        log(response.body.toString());
      }
    }

    privateKey = await Storage.readData(PrivateKeys.TRON);
    if (privateKey == null) {
      getPrivateKey().then((value) {
        return send();
      });
    } else {
      send();
    }
  }

  ///Sending BCH
  sendBCH({required String address, required double amount}) async {
    load.value = true;
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeBitcoinCash);
    log(walletAddress);
    String? privateKey;
    send() async {
      load.value = true;
      Uri uri = Uri.parse('https://api-us-west1.tatum.io/v3/bcash/transaction');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map body = {
        "fromUTXO": [
          {
            "txHash":
                "53faa103e8217e1520f5149a4e8c84aeb58e55bdab11164a95e69a8ca50f8fcc",
            "index": 0,
            "privateKey": privateKey
          }
        ],
        "to": [
          {
            "address": "bitcoincash:$address",
            "value": amount,
          }
        ]
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        if (results.containsKey("txId")) {
          // Get.toNamed(
          //   Routes.SEND_SUCCESS,
          //   arguments: {
          //     "amount": "$amount",
          //     "walletAddress": walletAddress,
          //   },
          // );
        }
      } else {
        load.value = false;
        cToast(title: "Notice", message: results['data'].toString());
        log(response.statusCode.toString());
        log(response.body.toString());
        //sent = false;
        log(results['message']);
        load.value = false;
      }
    }

    getPrivateKey() async {
      load.value = true;
      Uri uri = Uri.parse('https://api-us-west1.tatum.io/v3/bcash/wallet/priv');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map<String, dynamic> body = {
        'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
        'mnemonic': mnemonics
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        privateKey = results['key'];
        await Storage.saveData(PrivateKeys.BCH, results['key']);
      } else {
        log(response.statusCode.toString());
        log(response.body.toString());
      }
    }

    privateKey = await Storage.readData(PrivateKeys.BCH);
    if (privateKey == null) {
      getPrivateKey().then((value) {
        return send();
      });
    } else {
      send();
    }
  }

  ///Sending DOGE
  sendDOGE({required String address, required double amount}) async {
    load.value = true;
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeDogecoin);
    log(walletAddress);
    String? privateKey;
    send() async {
      load.value = true;
      Uri uri =
          Uri.parse('https://api-us-west1.tatum.io/v3/dogecoin/transaction');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map body = {
        "fee": "0.0015",
        "changeAddress": walletAddress,
        'fromAddress': [
          {
            "address": walletAddress,
            "privateKey": privateKey,
          }
        ],
        "to": [
          {
            "address": address,
            "value": amount,
          }
        ]
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        if (results.containsKey("txId")) {
          // Get.toNamed(
          //   Routes.SEND_SUCCESS,
          //   arguments: {
          //     "amount": "$amount",
          //     "walletAddress": walletAddress,
          //   },
          // );
        }
      } else {
        load.value = false;
        cToast(title: "Notice", message: results['data'].toString());
        log(response.statusCode.toString());
        log(response.body.toString());
        //sent = false;
        log(results['message']);
        load.value = false;
      }
    }

    getPrivateKey() async {
      load.value = true;
      Uri uri =
          Uri.parse('https://api-us-west1.tatum.io/v3/dogecoin/wallet/priv');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map<String, dynamic> body = {
        'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
        'mnemonic': mnemonics
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        privateKey = results['key'];
        await Storage.saveData(PrivateKeys.DOGE, results['key']);
      } else {
        log(response.statusCode.toString());
        log(response.body.toString());
      }
    }

    privateKey = await Storage.readData(PrivateKeys.DOGE);
    if (privateKey == null) {
      getPrivateKey().then((value) {
        return send();
      });
    } else {
      send();
    }
  }

  ///Sending MATIC
  sendMATIC({required String address, required double amount}) async {
    load.value = true;
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypePolygon);
    log(walletAddress);
    String? privateKey;
    send() async {
      load.value = true;
      Uri uri =
          Uri.parse('https://api-us-west1.tatum.io/v3/polygon/transaction');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map body = {
        "to": address,
        "currency": "MATIC",
        "amount": address,
        "fromPrivateKey": privateKey,
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        if (results.containsKey("txId")) {
          // Get.toNamed(
          //   Routes.SEND_SUCCESS,
          //   arguments: {
          //     "amount": "$amount",
          //     "walletAddress": walletAddress,
          //   },
          // );
        }
      } else {
        load.value = false;
        cToast(title: "Notice", message: results['data'].toString());
        log(response.statusCode.toString());
        log(response.body.toString());
        //sent = false;
        log(results['message']);
        load.value = false;
      }
    }

    getPrivateKey() async {
      load.value = true;
      Uri uri =
          Uri.parse('https://api-us-west1.tatum.io/v3/polygon/wallet/priv');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map<String, dynamic> body = {
        'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
        'mnemonic': mnemonics
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        privateKey = results['key'];
        await Storage.saveData(PrivateKeys.MATIC, results['key']);
      } else {
        log(response.statusCode.toString());
        log(response.body.toString());
      }
    }

    privateKey = await Storage.readData(PrivateKeys.MATIC);
    if (privateKey == null) {
      getPrivateKey().then((value) {
        return send();
      });
    } else {
      send();
    }
  }

  ///Sending XLM (unable to get private key from tatum)
  sendXLM({required String address, required double amount}) async {
    load.value = true;
    String mnemonics = await Storage.readData(WALLET_MNEMONICS);
    HDWallet wallet = HDWallet.createWithMnemonic(mnemonics);
    String walletAddress =
        wallet.getAddressForCoin(TWCoinType.TWCoinTypeStellar);
    log(walletAddress);
    String? privateKey;
    send() async {
      load.value = true;
      Uri uri = Uri.parse('https://api-us-west1.tatum.io/v3/xlm/transaction');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map body = {
        "fromAccount": walletAddress,
        "to": address,
        "amount": "$amount",
        "fromSecret": privateKey,
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        if (results.containsKey("txId")) {
          // Get.toNamed(
          //   Routes.SEND_SUCCESS,
          //   arguments: {
          //     "amount": "$amount",
          //     "walletAddress": walletAddress,
          //   },
          // );
        }
      } else {
        load.value = false;
        cToast(title: "Notice", message: results['data'].toString());
        log(response.statusCode.toString());
        log(response.body.toString());
        //sent = false;
        log(results['message']);
        load.value = false;
      }
    }

    getPrivateKey() async {
      load.value = true;
      Uri uri = Uri.parse('https://api-us-west1.tatum.io/v3/xlm/wallet/priv');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "x-api-key": "272d29bc-2236-40e0-a37e-65238c30fa5e_100",
      };
      Map<String, dynamic> body = {
        'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
        'mnemonic': mnemonics
      };

      http.Response response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      var results = jsonDecode(response.body);
      if (response.statusCode == 200) {
        load.value = false;
        privateKey = results['key'];
        await Storage.saveData(PrivateKeys.XLM, results['key']);
      } else {
        log(response.statusCode.toString());
        log(response.body.toString());
      }
    }

    privateKey = await Storage.readData(PrivateKeys.XLM);
    if (privateKey == null) {
      getPrivateKey().then((value) {
        return send();
      });
    } else {
      send();
    }
  }
}
