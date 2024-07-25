import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tigwaal_driver/cubit/payment_cubit.dart';
import 'package:tigwaal_driver/functions/functions.dart';
import 'package:tigwaal_driver/functions/notifications.dart';
import 'package:tigwaal_driver/share/dio_helper.dart';
import 'pages/loadingPage/loadingpage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  checkInternetConnection();
  initMessaging();
  await DioHelper.init();
  currentPositionUpdate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    platform = Theme.of(context).platform;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PaymentCubit()),
      ],
      child: GestureDetector(
          onTap: () {
            //remove keyboard on touching anywhere on the screen.
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Taxi madina Driver',
              theme: ThemeData(),
              home: const LoadingPage())),
    );
  }
}
