import 'package:binance_cl/services/api_service.dart';
import 'package:binance_cl/services/changenow_service.dart';

class APICalls {
  checkEmailExists(email) async {
    var req = await ApiService.getData("user/check_email/$email");
    return req;
  }

  checkPhoneExists(phone) async {
    var req = await ApiService.getData("user/check_phone/$phone");
    return req;
  }

  createAccount(data) async {
    var req = await ApiService.postData(data, 'user/create-account');
    return req;
  }

  loginWithEmail(data) async {
    var req = await ApiService.postData(data, 'user/login_email');
    return req;
  }

  loginWithPhone(data) async {
    var req = await ApiService.postData(data, 'user/login_phone');
    return req;
  }

  getUserProfile(email) async {
    var req = await ApiService.getDataWithToken('user/profile/$email');
    return req;
  }

  getCurrenciesList() async {
    var req = await ApiService.getListData( 
        'thirdparty/changenow_currencies_list');
    return req;
  }

  getMinimumExchangeAmount(pair) async {
    var req =
        await ApiService.getData('thirdparty/changenow_minimum_exchange_amount/$pair');
    return req;
  }

  getEstimatedExchangeAmount(pair, sourceAmount) async {
    var req = await ApiService.getData(
        'thirdparty/changenow_estimated_exchange_amount/$pair/$sourceAmount');
    return req;
  }

  getBinanceCryptoTicker() async {
    var req = await ApiService.getListData( 
        'thirdparty/crypto_ticker');
    return req;
  }
}
