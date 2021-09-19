import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:opena_front/components/sms_api.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:opena_front/screen/login_signup/sign_up_screen.dart';
import 'package:opena_front/components/input_text.dart';
import 'package:opena_front/components/input_button.dart';
import 'package:opena_front/components/app_base.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:opena_front/screen/main_screen.dart';

bool smsSendStatus;

class ChangePhoneScreen extends StatefulWidget {
  static String id = 'change_phone_screen';
  @override
  _ChangePhoneScreenState createState() => _ChangePhoneScreenState();
}

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {
  bool phoneLengthCheck = false;
  bool certSmsStatus = false;
  bool smsValidityStatus = true;
  String phoneNumber;
  String smsPhoneNumber;
  SmsApi smsApi = SmsApi();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '###  ####  ####', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return AppBase(
      needAppBar: true,
      title: '전화번호 변경하기',
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                  keyboardType: TextInputType.phone,
                  maxLength: 15,
                  hintText: '휴대폰 번호(- 없이 숫자만 입력)',
                  autofocus: false,
                ),
                SizedBox(
                  height: 8.0,
                ),
                InputButton(
                  color: phoneLengthCheck && smsValidityStatus
                      ? Colors.grey[700]
                      : Colors.grey[400],
                  needSplash: phoneLengthCheck,
                  onPressed: phoneLengthCheck
                      ? () async {
                          setState(() {
                            smsValidityStatus = false;
                          });
                          //TODOS: SMS재발송시 smsPhoneNumber이용해서 전화번호 전달해야함.
                          smsSendStatus = await smsApi.sendSMS();
                          if (smsSendStatus) {
                            Flushbar(
                              flushbarPosition: FlushbarPosition.TOP,
                              flushbarStyle: FlushbarStyle.GROUNDED,
                              message: "인증문자가 발송 되었습니다.",
                              duration: Duration(seconds: 3),
                            )..show(context);
                            setState(() {
                              phoneLengthCheck = false;
                            });
                          }
                        }
                      : () {},
                  child: smsValidityStatus
                      ? Text(
                          "인증문자 받기",
                          style: TextStyle(color: Colors.white),
                        )
                      : ValidityCountDown(
                          onFinished: () {
                            print('finished!');
                            setState(() {
                              smsValidityStatus = true;
                              phoneLengthCheck = true;
                            });
                          },
                        ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                InputText(
                  onChanged: (value) {
                    if (value.length == 6) {
                      setState(() {
                        certSmsStatus = true;
                      });
                    } else {
                      setState(() {
                        certSmsStatus = false;
                      });
                    }
                  },
                  autofocus: true,
                  maxLength: 6,
                  hintText: '인증번호 입력',
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('어떤 경우에도 타인에게 공유하지 마세요!')),
                SizedBox(
                  height: 40.0,
                ),
                Text('이용약관 및 개인정보 취급방침'),
                SizedBox(
                  height: 8.0,
                ),
                InputButton(
                  color: certSmsStatus ? Colors.redAccent : Colors.grey[400],
                  needSplash: certSmsStatus,
                  onPressed: certSmsStatus
                      ? () {
                          Navigator.pushNamed(context, MainScreen.id);
                        }
                      : () {},
                  child: Text(
                    '동의하고 시작하기',
                    style: TextStyle(color: Colors.white),
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

class ValidityCountDown extends StatelessWidget {
  ValidityCountDown({this.onFinished});
  Function onFinished;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Countdown(
        duration: Duration(seconds: 5),
        onFinish: onFinished,
        builder: (BuildContext ctx, Duration remaining) {
          int remainingSeconds = remaining.inSeconds - remaining.inMinutes * 60;
          return Text(
            '인증문자 다시 받기 (${remaining.inMinutes}분 ${remainingSeconds}초)',
            style: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }
}
