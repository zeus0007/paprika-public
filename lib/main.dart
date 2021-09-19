import 'package:flutter/material.dart';
import 'package:opena_front/screen/cert_center/cert_base_screen.dart';
import 'package:opena_front/screen/cert_center/cert_center_index_screen.dart';
import 'package:opena_front/screen/login_signup/change_phone_screen.dart';
import 'package:opena_front/screen/login_signup/email_login_screen.dart';
import 'package:opena_front/screen/not_use/index_screen.dart';
import 'package:opena_front/screen/main_screen.dart';
import 'package:opena_front/screen/login_signup/phone_cert_screen.dart';
// import 'package:opena_front/screen/login_signup/login_sign_up_screen.dart';
import 'package:opena_front/screen/login_signup/sign_up_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            textTheme: TextTheme(
                headline6: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0))),
      ),
      //TODOS: 개발용으로 첫페이지부터 시작안하도록함.
      initialRoute: MainScreen.id,
      // initialRoute: IndexScreen.id,
      routes: {
        IndexScreen.id: (context) => IndexScreen(),
        EmailLoginScreen.id: (context) => EmailLoginScreen(),
        PhoneCertificationScreen.id: (context) => PhoneCertificationScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        MainScreen.id: (context) => MainScreen(),
        CertCenterIndex.id: (context) => CertCenterIndex(),
        CertBaseScreen.id: (context) => CertBaseScreen(),
        ChangePhoneScreen.id: (context) => ChangePhoneScreen(),
      },
    );
  }
}
