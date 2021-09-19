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

class CertIncome extends StatefulWidget {
  CertIncome({this.goNext, this.scrollToTop});
  final Function goNext;
  final Function scrollToTop;
  @override
  _CertIncomeState createState() => _CertIncomeState();
}

class _CertIncomeState extends State<CertIncome> {
  var count = 1;
  List<Widget> contentsFields = [];

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
    certContentsFieldAdd();
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
      children: [
        Column(
          children:
              contentsFields != null ? contentsFields : [CertContentsField()],
        ),
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
        SizedBox(
          height: 24.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          margin: const EdgeInsets.only(left: 14, right: 30),
          decoration: BoxDecoration(
              color: Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '총소득',
                style: kContentsCalc,
              ),
              Text(
                '${total} 원',
                style: kContentsCalc,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 33.0,
        ),
        ScreenShotSample(asset: 'asset/images/test.jpg'),
        Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 14, right: 30),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: InputButton(
                    color: Color(0xFFD1D1D6),
                    needSplash: false,
                    onPressed: () {},
                    child: Text(
                      '신청 완료',
                      style: kContentsButton,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 9.0,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: InputButton(
                    color: Color(0xFFCD2A35),
                    needSplash: false,
                    onPressed: () {
                      setState(() {
                        this.widget.goNext();
                        this.widget.scrollToTop();
                      });
                    },
                    child: Text(
                      '다음',
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
              '월 소득',
              style: kContentsTitle,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '첨부된 사진과 동일한 금액을 입력해주세요.',
                    style: kContentsBody,
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
                    '스크린샷 첨부 (이미지 파일)',
                    style: kContentsBody,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                        elevation: 3,
                        color: Color(0xFFF4F4F4),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Color(0xFFF4F4F4),
                              width: 0,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        // onPressed: getImage,
                        onPressed: loadAssets,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 20.0,
                              ),
                              SizedBox(
                                width: 3.67,
                              ),
                              Text(
                                '파일 선택',
                                style: kContentsBodyAccent,
                              ),
                            ],
                          ),
                        ),
                      ),
                      images.length > 0 ? buildGridView() : Text(''),
                    ],
                  ),

                  //     ? Text('')
                  //     // : Image.file(
                  //     //     _image,
                  //     //     width: double.infinity,
                  //     //     fit: BoxFit.fitWidth,
                  //     //     alignment: FractionalOffset.center,
                  //     //   ),
                  //     :

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
