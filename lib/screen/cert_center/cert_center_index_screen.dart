import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:opena_front/arguments/cert_page_args.dart';
import 'package:opena_front/constants.dart';
import 'package:opena_front/screen/cert_center/cert_base_screen.dart';

class CertCenterIndex extends StatefulWidget {
  static String id = 'cert_center_index_screen';
  @override
  _CertCenterIndexState createState() => _CertCenterIndexState();
}

class _CertCenterIndexState extends State<CertCenterIndex> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0xFFEFEFF4),
            height: 5.0,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 15.0,
              bottom: 13.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  height: 25,
                  child: LiquidLinearProgressIndicator(
                    value: 0.75, // Defaults to 0.5.
                    valueColor: AlwaysStoppedAnimation(
                      Color(0xFF88AFE3),
                    ), // Defaults to the current Theme's accentColor.
                    backgroundColor: Colors
                        .white, // Defaults to the current Theme's backgroundColor.
                    borderColor: Colors.white,
                    borderWidth: 0,
                    borderRadius: 25.0,
                    direction: Axis
                        .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                    center: Container(
                      padding: EdgeInsets.only(right: 8.0),
                      alignment: Alignment.centerRight,
                      width: double.maxFinite,
                      child: Text(
                        "75 %",
                        style: kProgressBar,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 11.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.lock,
                      size: 20.0,
                      color: Color(0xFF48484A),
                    ),
                    Text(
                      '익명으로 안전하게 처리됩니다.',
                      style: kContentsBody,
                    ),
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Color(0xFF212428), width: 1),
                            ),
                          ),
                          child: Text(
                            '인증이 왜 필요한가요?',
                          ),
                        ),
                        onTap: () {},
                      ),
                      SizedBox(height: 15.0),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Color(0xFF212428), width: 1),
                            ),
                          ),
                          child: Text(
                            '인증 방법 상세 설명',
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  height: 38.0,
                  width: double.maxFinite,
                  child: Material(
                    color: Color(0xFF4A4F56),
                    borderRadius: BorderRadius.circular(25.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          CertBaseScreen.id,
                          arguments: CertPageArguments(0),
                        );
                      },
                      child: Text(
                        '시작하기',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xFFEFEFF4),
            height: 5.0,
          ),
          Material(
            color: Colors.white,
            child: MaterialButton(
              padding: EdgeInsets.all(0.0),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  CertBaseScreen.id,
                  arguments: CertPageArguments(0),
                );
              },
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.maxFinite,
                padding: EdgeInsets.only(
                    left: 16.0, right: 15.0, top: 12.0, bottom: 12.0),
                height: 44.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '소득',
                      style: kCertCenterIndexBtn,
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 25.0,
                      color: Color.fromRGBO(60, 60, 67, 0.3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            color: Colors.white,
            child: MaterialButton(
              padding: EdgeInsets.all(0.0),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  CertBaseScreen.id,
                  arguments: CertPageArguments(1),
                );
              },
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.maxFinite,
                padding: EdgeInsets.only(
                    left: 16.0, right: 15.0, top: 12.0, bottom: 12.0),
                height: 44.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '저축',
                      style: kCertCenterIndexBtn,
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 25.0,
                      color: Color.fromRGBO(60, 60, 67, 0.3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            color: Colors.white,
            child: MaterialButton(
              padding: EdgeInsets.all(0.0),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  CertBaseScreen.id,
                  arguments: CertPageArguments(2),
                );
              },
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.maxFinite,
                padding: EdgeInsets.only(
                    left: 16.0, right: 15.0, top: 12.0, bottom: 12.0),
                height: 44.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '투자',
                      style: kCertCenterIndexBtn,
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 25.0,
                      color: Color.fromRGBO(60, 60, 67, 0.3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            color: Colors.white,
            child: MaterialButton(
              padding: EdgeInsets.all(0.0),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  CertBaseScreen.id,
                  arguments: CertPageArguments(3),
                );
              },
              child: Container(
                alignment: Alignment.centerLeft,
                width: double.maxFinite,
                padding: EdgeInsets.only(
                    left: 16.0, right: 15.0, top: 12.0, bottom: 12.0),
                height: 44.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '기타',
                      style: kCertCenterIndexBtn,
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 25.0,
                      color: Color.fromRGBO(60, 60, 67, 0.3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: double.maxFinite,
              height: double.maxFinite,
              color: Color(0xFFEFEFF4),
            ),
          ),
        ],
      ),
    );
  }
}

// 원형 progressbar
// Center(
//   child: Container(
//     width: 200,
//     height: 200,
//     color: Colors.white,
//     child: LiquidCircularProgressIndicator(
//       value: 0.4, // Defaults to 0.5.
//       valueColor: AlwaysStoppedAnimation(
//         Colors.blue[100],
//       ), // Defaults to the current Theme's accentColor.
//       backgroundColor: Colors
//           .white, // Defaults to the current Theme's backgroundColor.
//       borderColor: Colors.black,
//       borderWidth: 18.0,
//       direction: Axis
//           .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
//       center: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "START",
//             style: TextStyle(
//                 fontSize: 30.0, fontWeight: FontWeight.bold),
//           ),
//           Text('40%'),
//         ],
//       ),
//     ),
//   ),
// )
