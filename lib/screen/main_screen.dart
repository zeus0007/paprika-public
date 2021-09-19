import 'package:flutter/material.dart';
import 'package:opena_front/components/app_base.dart';
import 'package:opena_front/components/input_button.dart';
import 'package:flutter/services.dart';
import 'package:opena_front/components/input_text_type2_label.dart';
import 'package:opena_front/screen/cert_center/cert_center_index_screen.dart';

class MainScreen extends StatefulWidget {
  static String id = 'main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //TODOS: createDialog가 처음 가입할때만 뜨도록 만들어야함.
  // false일때 뜨는거고 true일때 안뜨는 중.
  bool createDialog = true;
  bool showSaving = false;
  bool showConsum = false;
  bool showInvest = false;
  bool showSubmitBtn = false;
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
    });
  }

  List<String> titles = <String>['월급공유', '통계비교', '인증센터', '알림', '마이페이지'];
  List<Widget> bodies = <Widget>[
    Text("1"),
    Text("2"),
    CertCenterIndex(),
    Text("4"),
    Text("5")
  ];
  @override
  Widget build(BuildContext context) {
    if (createDialog == false) {
      Future.delayed(Duration.zero, () => showAlert(context));
    }

    return AppBase(
      needNavigatonBar: true,
      needAppBar: true,
      title: titles[_selectedIndex],
      hideBackButton: true,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      body: bodies[_selectedIndex],
    );
  }

  void showAlert(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.grey[200],
            contentPadding: EdgeInsets.zero,
            scrollable: true,
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    '기본 설정을 위해 입력해주세요! ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '0원 이상 입력 가능합니다.',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InputSet(
                    title: '월 소득',
                    autofocus: true,
                    onSubmitted: (value) {
                      setState(() {
                        createDialog = true;
                        showSaving = true;
                      });
                    },
                  ),
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: showSaving,
                      child: InputSet(
                        title: '월 저축 금액',
                        autofocus: true,
                        onSubmitted: (_) {
                          setState(() {
                            showConsum = true;
                          });
                        },
                      )),
                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: showConsum,
                    child: InputSet(
                      title: '월 소비 금액',
                      autofocus: true,
                      onSubmitted: (_) {
                        setState(() {
                          showInvest = true;
                        });
                      },
                    ),
                  ),
                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: showInvest,
                    child: InputSet(
                      title: '월 투자 금액',
                      autofocus: true,
                      onSubmitted: (_) {
                        setState(() {
                          showSubmitBtn = true;
                        });
                      },
                    ),
                  ),
                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: showSubmitBtn,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          InputButton(
                            color: Colors.grey[700],
                            needSplash: true,
                            onPressed: () {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              _formKey.currentState.save();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              '시작하기',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class InputSet extends StatelessWidget {
  InputSet({this.title, this.onSubmitted, this.autofocus, this.validator});
  final String title;
  final Function onSubmitted;
  final bool autofocus;
  final Function validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          InputLabel(text: title),
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
            ],
            keyboardType: TextInputType.datetime,
            autofocus: autofocus,
            validator: (value) {
              if (value.isEmpty) {
                return '금액을 정확히 입력해주세요.';
              } else {
                return null;
              }
            },
            onFieldSubmitted: onSubmitted,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              filled: true,
              fillColor: Colors.white,
              suffixText: '만원',
              border: InputBorder.none,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[900], width: 2.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
