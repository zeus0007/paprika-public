import 'package:flutter/material.dart';
import 'package:opena_front/components/app_base.dart';
import 'package:opena_front/screen/login_signup/phone_cert_screen.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

class IndexScreen extends StatefulWidget {
  static String id = 'index_screen';
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  bool onFocused = false;
  @override
  Widget build(BuildContext context) {
    return AppBase(
      needAppBar: false,
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  // Hero(
                  //   tag: 'logo',
                  //   child: Image.asset(
                  //     'asset/images/logo.jpg',
                  //     width: 250.0,
                  //   ),
                  // ),
                  Hero(
                    tag: 'title',
                    child: Material(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'OPEN ',
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'A',
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
            child: Column(
              children: [
                FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      onFocused = true;
                    });
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            PhoneCertificationScreen(),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: onFocused
                          ? BoxDecoration(
                              border: Border.all(
                                  color: Colors.redAccent, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            )
                          : BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey[400], width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                      child: Text(
                        '휴대폰 번호(- 없이 숫자만 입력)',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Material(
                    elevation: 5.0,
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(5.0),
                    child: MaterialButton(
                      onPressed: () {},
                      height: 42.0,
                      child: Text(
                        '인증번호 받기',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
