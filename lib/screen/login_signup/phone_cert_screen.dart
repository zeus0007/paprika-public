import 'package:flutter/material.dart';
import 'package:opena_front/components/sms_api.dart';
import 'package:opena_front/screen/login_signup/email_login_screen.dart';
import 'login_sign_up_screen.dart';
import 'package:opena_front/components/input_text.dart';
import 'package:opena_front/components/app_base.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneCertificationScreen extends StatefulWidget {
  static String id = 'phone_cert_screen';
  @override
  _PhoneCertificationScreenState createState() =>
      _PhoneCertificationScreenState();
}

class _PhoneCertificationScreenState extends State<PhoneCertificationScreen> {
  bool phoneLengthCheck = false;
  bool smsSendStatus;
  String phoneNumber;
  String smsPhoneNumber;
  SmsApi smsApi = SmsApi();
  bool showSpinner = false;
  var maskFormatter = new MaskTextInputFormatter(
      mask: '###  ####  ####', filter: {"#": RegExp(r'[0-9]')});
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
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'OPEN ',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'A',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     // Hero(
                  //     //   tag: 'logo',
                  //     //   child: Image.asset(
                  //     //     'asset/images/logo.jpg',
                  //     //     width: 150.0,
                  //     //   ),
                  //     // ),
                  //     Hero(
                  //       tag: 'title',
                  //       child: Material(
                  //         color: Colors.white,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Text(
                  //               'OPEN ',
                  //               style: TextStyle(
                  //                 fontSize: 50,
                  //                 color: Colors.black,
                  //               ),
                  //             ),
                  //             Text(
                  //               'A',
                  //               style: TextStyle(
                  //                 fontSize: 50,
                  //                 color: Colors.redAccent,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    '로그인/가입',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
            child: Column(
              children: [
                InputText(
                  inputFormatters: [maskFormatter],
                  onChanged: (value) {
                    phoneNumber = value;
                    smsPhoneNumber = phoneNumber.replaceAll(RegExp(' +'), '');

                    if (value.length > 14) {
                      setState(() {
                        phoneLengthCheck = true;
                      });
                    } else {
                      setState(() {
                        phoneLengthCheck = false;
                      });
                    }
                  },
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  maxLength: 15,
                  hintText: '휴대폰 번호(- 없이 숫자만 입력)',
                ),
                SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Material(
                    color:
                        phoneLengthCheck ? Colors.grey[700] : Color(0xFFE5E5EA),
                    borderRadius: BorderRadius.circular(5.0),
                    child: MaterialButton(
                      splashColor: phoneLengthCheck ? null : Colors.transparent,
                      highlightColor:
                          phoneLengthCheck ? null : Colors.transparent,
                      onPressed: phoneLengthCheck
                          ? () async {
                              setState(() {
                                showSpinner = true;
                              });
                              //TODO: SMS 발송 주석처리 나중에 풀어야함.
                              //TODO: SMS 발송시 전화번호 입력을 아직 안함. smsPhoneNumber 변수 이용
                              //smsSendStatus = await smsApi.sendSMS();
                              smsSendStatus = true; // 여기 삭제
                              if (smsSendStatus) {
                                setState(() {
                                  showSpinner = false;
                                });
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation1,
                                            animation2) =>
                                        LoginSignUpScreen(phone: phoneNumber),
                                  ),
                                );
                              }
                            }
                          : () {},
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '전화번호가 변경되었나요?',
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.2),
                    ),
                  ),
                  child: Text(
                    '이메일로  계정  찾기',
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, EmailLoginScreen.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
