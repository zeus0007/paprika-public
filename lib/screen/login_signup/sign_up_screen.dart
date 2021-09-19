import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opena_front/components/app_base.dart';
import 'package:opena_front/components/input_button.dart';
import 'package:opena_front/components/input_text.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:opena_front/components/input_text_type2.dart';
import 'package:opena_front/components/input_text_type2_label.dart';
import 'package:opena_front/screen/main_screen.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'sign_up_screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool birthStatus = false;
  bool nickStatus = false;
  bool inputStatus = false;
  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyBirth = GlobalKey<FormState>();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});
  @override
  Widget build(BuildContext context) {
    return AppBase(
      hideBackButton: true,
      needAppBar: true,
      title: '회원가입',
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputLabel(
                text: '이름',
              ),
              Form(
                key: _formKeyName,
                child: InputText2(
                  onChanged: (value) {
                    setState(() {
                      inputStatus = false;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return '이름은 필수 입력사항입니다.';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.name,
                  autofocus: true,
                  hintText: '이름',
                  onSubmitted: (value) {
                    FocusScope.of(context).nextFocus();
                    if (!_formKeyName.currentState.validate()) {
                      return;
                    }
                    _formKeyName.currentState.save();
                    setState(() {
                      birthStatus = true;
                    });
                  },
                ),
              ),
              Form(
                key: _formKeyBirth,
                child: Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: birthStatus,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        InputLabel(
                          text: '생년월일',
                        ),
                        InputText2(
                          inputFormatters: [maskFormatter],
                          validator: (value) {
                            if (value.isEmpty) {
                              return '생년월일은 필수 입력사항입니다. 연도포함 8자리';
                            } else if (value.length < 8) {
                              return '생년월일 8자리를 모두 입력해주세요.';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              inputStatus = false;
                            });
                          },
                          keyboardType: TextInputType.datetime,
                          autofocus: true,
                          hintText: '생년월일',
                          onSubmitted: (_) {
                            if (!_formKeyBirth.currentState.validate()) {
                              return;
                            }
                            _formKeyBirth.currentState.save();
                            setState(() {
                              nickStatus = true;
                              inputStatus = true;
                            });
                            FocusScope.of(context).nextFocus();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: nickStatus,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      InputLabel(
                        text: '닉네임',
                      ),
                      InputText2(
                        onChanged: (value) {},
                        keyboardType: TextInputType.name,
                        autofocus: true,
                        hintText: '미입력시 \'익명\'으로 자동 설정됩니다.',
                        onSubmitted: (_) {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InputButton(
                      needSplash: inputStatus,
                      color: inputStatus ? Colors.redAccent : Colors.grey[400],
                      onPressed: () {
                        if (inputStatus) {
                          Navigator.pushNamed(context, MainScreen.id);
                        } else {
                          if (birthStatus) {
                            if (!_formKeyName.currentState.validate()) {
                              return;
                            }
                            _formKeyName.currentState.save();
                            if (!_formKeyBirth.currentState.validate()) {
                              return;
                            }
                            _formKeyBirth.currentState.save();
                            setState(() {
                              nickStatus = true;
                              inputStatus = true;
                            });
                          } else {
                            if (!_formKeyName.currentState.validate()) {
                              return;
                            }
                            _formKeyName.currentState.save();
                            setState(() {
                              birthStatus = true;
                            });
                          }
                        }
                      },
                      child: Text(
                        inputStatus ? '회원가입' : '다음',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class InputLabel extends StatelessWidget {
//   InputLabel({@required this.text});
//   String text;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 5.0),
//       padding: EdgeInsets.symmetric(horizontal: 3.0),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: 17,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }

// class InputDoneView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       color: Colors.grey[300],
//       child: Align(
//         alignment: Alignment.topRight,
//         child: Padding(
//           padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
//           child: CupertinoButton(
//             padding: EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
//             onPressed: () {
//               FocusScope.of(context).nextFocus();
//             },
//             child: Text(
//               "Done",
//               style: TextStyle(
//                   color: Colors.redAccent, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
