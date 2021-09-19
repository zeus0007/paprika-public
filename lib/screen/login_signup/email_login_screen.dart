import 'package:flutter/material.dart';
import 'package:opena_front/components/app_base.dart';
import 'package:opena_front/components/email_api.dart';
import 'package:opena_front/components/input_button.dart';
import 'package:opena_front/components/input_text.dart';
import 'package:opena_front/screen/login_signup/email_cert_screen.dart';

class EmailLoginScreen extends StatefulWidget {
  static String id = 'email_login';
  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  var email;
  bool emailValid = false;
  bool emailSendStatus;
  EmailApi emailApi = EmailApi();

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("안내사항"),
          content:
              new Text("이메일을 등록하지 않고 핸드폰을 변경하신 경우 wpdn79@naver.com으로 연락주세요."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBase(
      needAppBar: true,
      title: '이메일로 계정찾기',
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            InputText(
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
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
              height: 10,
            ),
            InputButton(
              needSplash: true,
              color: emailValid ? Color(0xFFFF6058) : Color(0xFFE5E5EA),
              onPressed: emailValid
                  ? () async {
                      emailSendStatus = await emailApi.sendEmail();
                      print('hellooooooo');
                      print(emailSendStatus);
                      setState(() {});
                      if (emailSendStatus) {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                EmailCertScreen(email: email),
                          ),
                        );
                      }
                    }
                  : () {},
              child: Text(
                '인증메일 받기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 29,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '이메일을 등록한 적이 없으세요?',
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
                      '문의하기',
                    ),
                  ),
                  onTap: _showDialog,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
