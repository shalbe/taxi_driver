import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagyourtaxi_driver/cubit/payment_state.dart';
import 'package:tagyourtaxi_driver/functions/const.dart';
import 'package:tagyourtaxi_driver/functions/functions.dart';
import 'package:tagyourtaxi_driver/model/add_amount_model.dart';
import 'package:tagyourtaxi_driver/model/first_token.dart';
import 'package:tagyourtaxi_driver/model/get_add.dart';
import 'package:tagyourtaxi_driver/model/get_api_key.dart';
import 'package:tagyourtaxi_driver/model/get_wallet.dart';
import 'package:tagyourtaxi_driver/model/order_id_model.dart';
import 'package:tagyourtaxi_driver/share/dio_helper.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit get(context) => BlocProvider.of(context);
  FirstTokenModel? firsttoken;
  OrderIdModel? orderid;

// payment
  Future PaymentWithCard({
    required String firstname,
    required String lastName,
    required String email,
    required String phone,
    required int price,
    String? integrationmethod,
  }) async {
    DioHelper.postData(
        url: authenticationrequesturl,
        data: {"api_key": paymentApiKey}).then((value) {
      paymentFirstToken = value?.data['token'];
      print('first token is :$paymentFirstToken');
      getOrderId(firstname, lastName, email, phone, price, integrationmethod!);

      emit(PaymentSuccess());
    }).catchError((error) {
      print('error is :' + error.toString());
      emit(PaymentError(error.toString()));
    });
  }

// OrdeId
  Future getOrderId(
    String firstname,
    String lastName,
    String email,
    String phone,
    int price,
    String integrationmethod,
  ) async {
    DioHelper.postData(url: orderidurl, data: {
      'auth_token': paymentFirstToken,
      'delivery_needed': false,
      'amount_cents': "${price * 100}",
      "currency": "EGP",
      'merchant_order_id': orderIdCard,
      'items': [],
    }).then((value) {
      paymentOrderId = value!.data['id'].toString();
      print('orderid is :$paymentOrderId');
      getPaymentkeyToken(
          lastName: lastName,
          firstname: firstname,
          email: email,
          price: price,
          phone: phone,
          integrationmethod: integrationmethod);

      emit(PaymentGetOrderIdSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(PaymentGetOrderIdError(error.toString()));
    });
  }

// PaymentkeyToken
  Future getPaymentkeyToken({
    required String firstname,
    required String lastName,
    required String email,
    required String phone,
    required int price,
    required String integrationmethod,
  }) async {
    DioHelper.postData(url: paymentkeytokenurl, data: {
      "auth_token": paymentFirstToken,
      "amount_cents": "${price * 100}",
      "expiration": 3600,
      "order_id": paymentOrderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstname,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": integrationmethod,
      "lock_order_when_paid": "false"
    }).then((value) {
      finalToken = value!.data['token'].toString();
      print('final token is :$finalToken');

      emit(PaymentkeyTokenSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(PaymentkeyTokenError(error.toString()));
    });
  }

  Future PaymentWithValu({
    required String firstname,
    required String lastName,
    required String email,
    required String phone,
    required int price,
    String? integrationmethod,
  }) async {
    DioHelper.postData(
        url: authenticationrequesturl,
        data: {"api_key": paymentApiKey}).then((value) {
      paymentFirstToken = value?.data['token'];
      print('first token is :$paymentFirstToken');
      getOrderIdValu(
          firstname, lastName, email, phone, price, integrationmethod!);

      emit(PaymentSuccessValu());
    }).catchError((error) {
      print('error is :' + error.toString());
      emit(PaymentErrorValu(error.toString()));
    });
  }

// OrdeId
  Future getOrderIdValu(
    String firstname,
    String lastName,
    String email,
    String phone,
    int price,
    String integrationmethod,
  ) async {
    DioHelper.postData(url: orderidurl, data: {
      'auth_token': paymentFirstToken,
      'delivery_needed': false,
      'amount_cents': "${price * 100}",
      "currency": "EGP",
      'merchant_order_id': orderIdCard,
      'items': [],
    }).then((value) {
      paymentOrderId = value!.data['id'].toString();
      print('orderid is :$paymentOrderId');
      getPaymentkeyTokenValu(
          firstname: firstname,
          lastName: lastName,
          email: email,
          price: price,
          phone: phone,
          integrationmethod: integrationmethod);

      emit(PaymentGetOrderIdSuccessValu());
    }).catchError((error) {
      print(error.toString());
      emit(PaymentGetOrderIdErrorValu(error.toString()));
    });
  }

// PaymentkeyToken
  Future getPaymentkeyTokenValu({
    required String firstname,
    required String lastName,
    required String email,
    required String phone,
    required int price,
    required String integrationmethod,
  }) async {
    DioHelper.postData(url: paymentkeytokenurl, data: {
      "auth_token": paymentFirstToken,
      "amount_cents": "${price * 100}",
      "expiration": 3600,
      "order_id": paymentOrderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstname,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": integrationIDValu,
      "lock_order_when_paid": "false"
    }).then((value) {
      finalToken = value!.data['token'].toString();
      print('final token is :$finalToken');

      emit(PaymentkeyTokenSuccessValu());
    }).catchError((error) {
      print(error.toString());
      emit(PaymentkeyTokenErrorValu(error.toString()));
    });
  }

  Future PaymentWithWallet({
    required String firstname,
    required String email,
    required String lastName,
    required String phone,
    required int price,
    String? integrationmethod,
  }) async {
    DioHelper.postData(
        url: authenticationrequesturl,
        data: {"api_key": paymentApiKey}).then((value) {
      paymentFirstToken = value?.data['token'];
      print('first token is :$paymentFirstToken');
      getOrderIdWallet(
          firstname, lastName, email, phone, price, integrationmethod!);

      emit(PaymentSuccessWallet());
    }).catchError((error) {
      print('error is :' + error.toString());
      emit(PaymentErrorWallet(error.toString()));
    });
  }

// OrdeId
  Future getOrderIdWallet(
    String firstname,
    String lastName,
    String email,
    String phone,
    int price,
    String integrationmethod,
  ) async {
    DioHelper.postData(url: orderidurl, data: {
      'auth_token': paymentFirstToken,
      'delivery_needed': false,
      'amount_cents': "${price * 100}",
      "currency": "EGP",
      'merchant_order_id': orderIdCard,
      'items': [],
    }).then((value) {
      paymentOrderId = value!.data['id'].toString();
      print('orderid is :$paymentOrderId');
      getPaymentkeyTokenWallet(
          firstname: firstname,
          lastName: lastName,
          email: email,
          price: price,
          phone: phone,
          integrationmethod: integrationmethod);
      emit(PaymentGetOrderIdSuccessWallet());
    }).catchError((error) {
      print(error.toString());
      emit(PaymentGetOrderIdErrorWallet(error.toString()));
    });
  }

// PaymentkeyToken
  Future getPaymentkeyTokenWallet({
    required String firstname,
    required String lastName,
    required String email,
    required String phone,
    required int price,
    required String integrationmethod,
  }) async {
    DioHelper.postData(url: paymentkeytokenurl, data: {
      "auth_token": paymentFirstToken,
      "amount_cents": "${price * 100}",
      "expiration": 3600,
      "order_id": paymentOrderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": firstname,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": lastName,
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": integrationmethod,
      "lock_order_when_paid": "false"
    }).then((value) {
      finalToken = value!.data['token'].toString();
      print('final token is :$finalToken');
      getVodafoneCash(phone);

      emit(PaymentkeyTokenSuccessWallet());
    }).catchError((error) {
      print(error.toString());
      emit(PaymentkeyTokenErrorWallet(error.toString()));
    });
  }

//get ref code
  GetWalletModel? getWalletModel;
  Future getVodafoneCash(String phone) async {
    DioHelper.postData(url: paymentReferencecodeurl, data: {
      "source": {"identifier": phone, "subtype": "WALLET"},
      "payment_token": finalToken
    }).then((value) {
      print(value);
      refcode = value!.data['id'].toString();
      iframeRedirectionUrl = value.data['iframe_redirection_url'].toString();
      // getWalletModel = GetWalletModel.fromJson(value.data);
      // iframeRedirectionUrl = getWalletModel!.iframeRedirectionUrl;
      print('referance code is :$iframeRedirectionUrl');

      emit(PaymentkReferencecodeSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(PaymentReferencecodeError(error.toString()));
    });
  }

//paymentKiosk
  Future paymentKiosk({
    required String firstname,
    required String lastName,
    required String lastname,
    required String email,
    required String phone,
    required int price,
  }) async {
    DioHelper.postData(
        url: authenticationrequesturl,
        data: {"api_key": paymentApiKey}).then((value) {
      paymentFirstToken = value?.data['token'];
      print('first token is :$paymentFirstToken');
      // getOrderId();
      getPaymentkeyToken(
          firstname: firstname,
          lastName: lastName,
          email: email,
          price: price,
          phone: phone,
          integrationmethod: integrationIDKiosk);
      // getRefererencCodeKiosk();

      emit(PaymentSuccess());
    }).catchError((error) {
      print('error is :' + error.toString());
      emit(PaymentError(error.toString()));
    });
  }

  GetApiKeyModel? getApiKeyModel;
  void getApiKeyValue({
    String? firstname,
    String? lastName,
    String? email,
    String? phone,
    int? price,
    String? integrationmethod,
  }) {
    DioHelper.getDataa(url: '${url}api/v1/payment/paymob/credentials')
        .then((value) {
      getApiKeyModel = GetApiKeyModel.fromJson(value!.data);
      paymentApiKey = getApiKeyModel!.data!.apiKey;
      integrationIDCard = getApiKeyModel!.data!.integrationId;
      integrationIDValu = getApiKeyModel!.data!.valueIntegrationId;
      integrationIDWallet = getApiKeyModel!.data!.walletIntegrationId;
      iframeIdCard = getApiKeyModel!.data!.iframeId;
      iframeIdValu = getApiKeyModel!.data!.valueIframeId;
      print(integrationIDValu);
      print(iframeIdValu);
      addAmount('${price! * 100}');
      Timer(Duration(seconds: 2), () {
        PaymentWithValu(
            firstname: firstname!,
            lastName: lastName!,
            email: email!,
            phone: phone!,
            price: price,
            integrationmethod: integrationIDValu);
      });
      emit(GetApiSuccess());
    }).catchError((er) {
      print(er.toString());
      emit(GetApiError(er.toString()));
    });
  }

  void getApiKeyCard({
    String? firstname,
    String? lastName,
    String? email,
    String? phone,
    int? price,
    String? integrationmethod,
  }) {
    DioHelper.getDataa(url: '${url}api/v1/payment/paymob/credentials')
        .then((value) {
      getApiKeyModel = GetApiKeyModel.fromJson(value!.data);
      paymentApiKey = getApiKeyModel!.data!.apiKey;
      integrationIDCard = getApiKeyModel!.data!.integrationId;
      integrationIDValu = getApiKeyModel!.data!.valueIntegrationId;
      integrationIDWallet = getApiKeyModel!.data!.walletIntegrationId;
      iframeIdCard = getApiKeyModel!.data!.iframeId;
      iframeIdValu = getApiKeyModel!.data!.valueIframeId;
      print(integrationIDValu);
      print(integrationIDCard);
      addAmount('${price! * 100}');
      Timer(Duration(seconds: 2), () {
        PaymentWithCard(
            firstname: firstname!,
            lastName: lastName!,
            email: email!,
            phone: phone!,
            price: price,
            integrationmethod: integrationIDCard);
      });
      emit(GetApiSuccess());
    }).catchError((er) {
      print(er.toString());
      emit(GetApiError(er.toString()));
    });
  }

  void getApiKeyValueWallet({
    String? firstname,
    String? lastName,
    String? email,
    String? phone,
    int? price,
    String? integrationmethod,
  }) {
    DioHelper.getDataa(url: '${url}api/v1/payment/paymob/credentials')
        .then((value) {
      getApiKeyModel = GetApiKeyModel.fromJson(value!.data);
      paymentApiKey = getApiKeyModel!.data!.apiKey;
      integrationIDCard = getApiKeyModel!.data!.integrationId;
      integrationIDValu = getApiKeyModel!.data!.valueIntegrationId;
      integrationIDWallet = getApiKeyModel!.data!.walletIntegrationId;
      iframeIdCard = getApiKeyModel!.data!.iframeId;
      iframeIdValu = getApiKeyModel!.data!.valueIframeId;
      print(integrationIDValu);
      addAmount('${price! * 100}');
      Timer(Duration(seconds: 2), () {
        PaymentWithWallet(
            firstname: firstname!,
            email: email!,
            lastName: lastName!,
            phone: phone!,
            price: price,
            integrationmethod: integrationIDWallet);
      });
      emit(GetApiSuccess());
    }).catchError((er) {
      print(er.toString());
      emit(GetApiError(er.toString()));
    });
  }

  AddAmountModel? addAmountModel;
  void addAmount(amount) {
    FormData formData = FormData.fromMap({'amount': amount});
    DioHelper.postDataa(
            url: '${url}api/v1/payment/paymob/checkout', data: formData)
        .then((value) {
      addAmountModel = AddAmountModel.fromJson(value!.data);
      orderIdCard = addAmountModel!.data!.orderId.toString();
      print('order id ===========${orderIdCard}');
      emit(AddAmountSuccess());
    }).catchError((er) {
      print(er.toString());
      emit(AddAmountError(er.toString()));
    });
  }

  GetAdd? getAdd;
  void getAdds() {
    emit(GetADDLoading());
    DioHelper.getDataa(url: '${url}api/v1/ads').then((value) {
      getAdd = GetAdd.fromJson(value!.data);
      emit(GetADDSuccess());
    }).catchError((er) {
      print(er.toString());
      emit(GetADDError());
    });
  }
}
