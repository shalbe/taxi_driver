import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tagyourtaxi_driver/cubit/payment_cubit.dart';
import 'package:tagyourtaxi_driver/cubit/payment_state.dart';
import 'package:tagyourtaxi_driver/functions/const.dart';
import 'package:tagyourtaxi_driver/functions/functions.dart';
import 'package:tagyourtaxi_driver/pages/NavigatorPages/visascreen.dart';
import 'package:tagyourtaxi_driver/pages/NavigatorPages/vodafone_cash_screen.dart';
import 'package:tagyourtaxi_driver/styles/styles.dart';

class WalletPhone extends StatelessWidget {
  int? price;
  WalletPhone({Key? key, this.price}) : super(key: key);
  var phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(listener: (context, state) {
      if (state is PaymentkReferencecodeSuccess) {
        // PaymentCubit.get(context).getVodafoneCash(phone.text);
        print('=================>>>>>$iframeRedirectionUrl');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => VodafoneCashScreen()));
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 120, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/download (2).png'))),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  height: 45,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: .2),
                  ),
                  child: TextField(
                    controller: phone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      border: InputBorder.none,
                      hintText: 'Enter your phone',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  PaymentCubit.get(context).getApiKeyValueWallet(
                      email: userDetails['email'] ?? "",
                      firstname: userDetails['name'] ?? "",
                      integrationmethod: integrationIDWallet,
                      lastName: userDetails['name'] ?? "",
                      phone: phone.text,
                      price: price!);
                },
                child: Container(
                  height: 40,
                  width: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: buttonColor),
                  child: Center(
                    child: Text(
                      'Pay',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
