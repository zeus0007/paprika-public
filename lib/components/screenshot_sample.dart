import 'package:flutter/material.dart';
import 'package:opena_front/constants.dart';

class ScreenShotSample extends StatelessWidget {
  const ScreenShotSample({@required this.asset});
  final String asset;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Padding(
        padding: EdgeInsets.only(left: 14.0, right: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '스크린샷 예시',
              style: kContentsTitle,
            ),
            SizedBox(height: 10),
            Material(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 5.0,
              child: Container(
                width: double.infinity,
                height: 164,
                decoration: BoxDecoration(
                  //TODO: 보더선 지우기
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    alignment: FractionalOffset.center,
                    image: AssetImage(asset),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'text area - SF Pro Text, 13, regular size',
              style: kContentsBody,
            ),
          ],
        ),
      ),
    );
  }
}
