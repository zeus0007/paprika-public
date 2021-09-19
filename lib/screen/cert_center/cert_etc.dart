import 'package:flutter/material.dart';
import 'package:opena_front/components/cert_input_text.dart';
import 'package:opena_front/components/screenshot_sample.dart';
import 'package:opena_front/constants.dart';

import 'package:image_picker/image_picker.dart';
import 'package:opena_front/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:opena_front/components/input_button.dart';

bool isOne = true;
int total = 0;

class CertEtc extends StatefulWidget {
  CertEtc({this.goNext, this.scrollToTop});
  final Function goNext;
  final Function scrollToTop;
  @override
  _CertEtcState createState() => _CertEtcState();
}

class _CertEtcState extends State<CertEtc> {
  var count = 1;
  List<Widget> contentsFields = [];
  bool isLiveWithFamily = false;
  bool isMarried = false;
  bool haveCar = false;
  bool haveLoan = true;
  int _value = 1;

  countPlusCB() {
    setState(() {
      count++;
      certContentsFieldAdd();
      if (count == 1) {
        isOne = true;
      } else {
        isOne = false;
      }
    });
  }

  countMinusCB(Key key) {
    if (count <= 1) {
      _showDialog();
    } else {
      contentsFields.removeWhere((item) {
        return item.key == key;
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Text("1개 이하로 작성할 수 없습니다."),
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

  void certContentsFieldAdd() {
    contentsFields.add(CertContentsField(
        cbPlus: countPlusCB, cbMinus: countMinusCB, key: UniqueKey()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '월 소비',
          style: kContentsTitle,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 9.0,
              ),
              Text(
                '월 소비 금액을 입력해주세요.',
                style: kContentsTextFieldSubLabel,
              ),
              SizedBox(
                height: 11.0,
              ),
              CertTextInputBox(
                kContentsTextFieldLabel: kContentsTextFieldLabel,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        SizedBox(height: 26.0),
        Text(
          '해당되는 내역을 선택해주세요.',
          style: kContentsTitle,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.0,
              ),
              Text(
                '2개 이상 선택',
                style: kContentsTextFieldSubLabelGray,
              ),
              SizedBox(
                height: 9.5,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 29,
                                  width: 35,
                                  child: Checkbox(
                                    activeColor: Color(0xFF4A4F56),
                                    value: !isLiveWithFamily,
                                    onChanged: (value) {
                                      setState(() {
                                        isLiveWithFamily = !value;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  '자취',
                                  style: kBlackRegular15,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 29,
                                  width: 35,
                                  child: Checkbox(
                                    activeColor: Color(0xFF4A4F56),
                                    value: isLiveWithFamily,
                                    onChanged: (value) {
                                      setState(() {
                                        isLiveWithFamily = value;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  '본가 거주',
                                  style: kBlackRegular15,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 29,
                                  width: 35,
                                  child: Checkbox(
                                    activeColor: Color(0xFF4A4F56),
                                    value: haveCar,
                                    onChanged: (value) {
                                      setState(() {
                                        haveCar = value;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  '자동차 소유',
                                  style: kBlackRegular15,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 29,
                                    width: 35,
                                    child: Checkbox(
                                      activeColor: Color(0xFF4A4F56),
                                      value: !isMarried,
                                      onChanged: (value) {
                                        setState(() {
                                          isMarried = !value;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    '미혼',
                                    style: kBlackRegular15,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 29,
                                    width: 35,
                                    child: Checkbox(
                                      activeColor: Color(0xFF4A4F56),
                                      value: isMarried,
                                      onChanged: (value) {
                                        setState(() {
                                          isMarried = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Text(
                                    '기혼',
                                    style: kBlackRegular15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 23.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '대출',
              style: kContentsTitle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '대출 금액을 입력해주세요.',
                    style: kContentsTextFieldSubLabel,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  CertTextInputBox(
                    kContentsTextFieldLabel: kContentsTextFieldLabel,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '상품 종류',
                    style: kContentsTextFieldSubLabel,
                  ),
                  DropdownButton(
                    value: _value,
                    underline: Container(
                      height: 2,
                      color: Color(0xFFD1D1D6),
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Container(
                          padding: EdgeInsets.only(right: 50.0),
                          child: Text(
                            "주택자금대출",
                            style: kContentsDropdownText,
                          ),
                        ),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "전세자금대출",
                          style: kContentsDropdownText,
                        ),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "일반 대출",
                          style: kContentsDropdownText,
                        ),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "기타",
                          style: kContentsDropdownText,
                        ),
                        value: 2,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 29,
                        width: 35,
                        child: Checkbox(
                          activeColor: Color(0xFF4A4F56),
                          value: !haveLoan,
                          onChanged: (value) {
                            setState(() {
                              isMarried = value;
                            });
                          },
                        ),
                      ),
                      Text(
                        '없음',
                        style: kBlackRegular15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 23.0),
        Column(
            children: contentsFields.length != 0
                ? contentsFields
                : [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 16.67,
                          height: 16.67,
                          child: IconButton(
                            onPressed: () {
                              countPlusCB();
                            },
                            padding: EdgeInsets.all(0.0),
                            icon: Icon(
                              Icons.add_circle,
                              size: 16.0,
                              color: Color(0xFF4A4F56),
                            ),
                          ),
                        ),
                        SizedBox(width: 1.0),
                        Text(
                          '비정기적 소득',
                          style: kContentsTitle,
                        ),
                      ],
                    ),
                  ]),
        contentsFields.length != 0
            ? Container(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20.0,
                      height: 20.0,
                      child: IconButton(
                        onPressed: () {
                          countPlusCB();
                        },
                        padding: EdgeInsets.all(0.0),
                        icon: Icon(
                          Icons.add_circle,
                          size: 20.0,
                          color: Color(0xFF4A4F56),
                        ),
                      ),
                    ),
                    Text('추가하기', style: kContentsAddButton),
                  ],
                ),
              )
            : SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 14, right: 30),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: InputButton(
                    color: Color(0xFFCD2A35),
                    needSplash: false,
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(
                      '인증 완료',
                      style: kContentsButton,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
//TODOS: 이미지 삽입

class CertContentsField extends StatefulWidget {
  CertContentsField({
    Key key,
    this.cbPlus,
    this.cbMinus,
    // this.cbTotal,
  }) : super(key: key);
  final Function cbPlus;
  final Function cbMinus;
  // final ValueSetter<int> cbTotal;

  @override
  _CertContentsFieldState createState() => _CertContentsFieldState();
}

class _CertContentsFieldState extends State<CertContentsField> {
  // _IncomeCertScreenState parent;
  // File _image;
  final picker = ImagePicker();
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  int amount = 0;
  int _value = 1;

  Widget buildGridView() {
    return Row(
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Container(
          padding: EdgeInsets.only(left: 10.0),
          child: AssetThumb(
            asset: asset,
            width: 70,
            height: 70,
          ),
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    checkPermission();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        //TODO: 이부분 설정에 맞게 바꿔야함.
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
      print(images);
    });
  }

  //이미지 권한부여
  Future<bool> checkPermission() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.photos].request();

    bool per = true;
    statuses.forEach((permission, permissionStatus) {
      if (!permissionStatus.isGranted) {
        per = false;
        AppSettings.openAppSettings();
        print('권한 없슈');
      } else {
        print('권한 있슈');
      }
    });
    return per;
  }

  void _deleteConfrimDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Text("삭제하시겠습니까?"),
          actions: <Widget>[
            FlatButton(
              child: Text("확인"),
              onPressed: () {
                this.widget.cbMinus(this.widget.key);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("닫기"),
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
    // final counter = Provider.of<Counter>(context);

    return Container(
      margin: EdgeInsets.only(top: 10),
      width: double.maxFinite,
      child: Material(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '비정기적 소득',
              style: kContentsTitle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '첨부된 사진과 동일한 금액을 입력해주세요.',
                    style: kContentsTextFieldSubLabelGray,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  CertTextInputBox(
                    kContentsTextFieldLabel: kContentsTextFieldLabel,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '종류',
                    style: kContentsTextFieldSubLabelGray,
                  ),
                  DropdownButton(
                    value: _value,
                    underline: Container(
                      height: 2,
                      color: Color(0xFFD1D1D6),
                    ),
                    items: [
                      DropdownMenuItem(
                        child: Container(
                          padding: EdgeInsets.only(right: 50.0),
                          child: Text(
                            "아르바이트",
                            style: kContentsDropdownText,
                          ),
                        ),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "전세자금대출",
                          style: kContentsDropdownText,
                        ),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "보너스",
                          style: kContentsDropdownText,
                        ),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "상여금",
                          style: kContentsDropdownText,
                        ),
                        value: 2,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        _deleteConfrimDialog();

                        // print(_IncomeCertScreenState.of(context))
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        size: 20.0,
                        color: Color(0xFFD1D1D6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
