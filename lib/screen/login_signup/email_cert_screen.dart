import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:opena_front/components/app_base.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:opena_front/components/email_api.dart';
import 'package:opena_front/components/input_button.dart';
import 'package:opena_front/components/input_text.dart';
import 'package:opena_front/screen/login_signup/change_phone_screen.dart';

class EmailCertScreen extends StatefulWidget {
  EmailCertScreen({@required this.email});
  static String id = 'email_cert_screen';
  final String email;
  @override
  _EmailCertScreenState createState() => _EmailCertScreenState();
}

class _EmailCertScreenState extends State<EmailCertScreen> {
  String email;
  bool emailValid = true;
  bool emailValidityStatus = false;
  bool emailSendStatus;
  bool certEmailStatus = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    email = widget.email;
    controller = TextEditingController(text: "$email");
    WidgetsBinding.instance.addPostFrameCallback((_) => Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.GROUNDED,
          message: "인증 메일이 발송 되었습니다.",
          duration: Duration(seconds: 3),
        )..show(context));
  }

  @override
  Widget build(BuildContext context) {
    return AppBase(
      needAppBar: true,
      title: '이메일로 계정찾기',
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                InputText(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  controller: controller,
                  hintText: '이메일 주소',
                  onChanged: (value) {
                    setState(() {
                      email = value;
                      emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email);
                    });
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                InputButton(
                  color: emailValid && emailValidityStatus
                      ? Colors.grey[700]
                      : Colors.grey[400],
                  needSplash: emailValid,
                  onPressed: emailValid
                      ? () async {
                          setState(() {
                            emailValidityStatus = false;
                          });
                          //TODOS: SMS재발송시 smsPhoneNumber이용해서 전화번호 전달해야함.
                          emailSendStatus = await EmailApi().sendEmail();
                          if (emailSendStatus) {
                            Flushbar(
                              flushbarPosition: FlushbarPosition.TOP,
                              flushbarStyle: FlushbarStyle.GROUNDED,
                              message: "인증메일이 재발송 되었습니다.",
                              duration: Duration(seconds: 3),
                            )..show(context);
                            setState(() {
                              emailValid = false;
                            });
                          }
                        }
                      : () {},
                  child: emailValidityStatus
                      ? Text(
                          "인증메일 재발송",
                          style: TextStyle(color: Colors.white),
                        )
                      : ValidityCountDown(
                          onFinished: () {
                            print('finished!');
                            setState(() {
                              emailValidityStatus = true;
                              emailValid = true;
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
                        certEmailStatus = true;
                      });
                    } else {
                      setState(() {
                        certEmailStatus = false;
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
                  color: certEmailStatus ? Color(0xFFED3B43) : Colors.grey[400],
                  needSplash: certEmailStatus,
                  onPressed: certEmailStatus
                      ? () {
                          Navigator.pushNamed(context, ChangePhoneScreen.id);
                        }
                      : () {},
                  child: Text(
                    '이메일로 시작하기',
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
            '인증메일 다시 받기 (${remaining.inMinutes}분 ${remainingSeconds}초)',
            style: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }
}
