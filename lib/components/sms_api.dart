import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:opena_front/config.dart';

class SmsApi {
  Future sendSMS() async {
    String serviceId = Uri.encodeComponent('ncp:sms:kr:260816320872:parika');
    String timeStamp = (DateTime.now().millisecondsSinceEpoch).toString();
    String accessKey = ACCESSKEY;
    String secretKey = SECRETKEY;

    String sig = getSignature(serviceId, timeStamp, accessKey, secretKey);
    final msg = jsonEncode({
      "type": "SMS",
      "from": "01075640545",
      "content": "[파프리카] 인증번호 [123456]를 입력해주세요.",
      "messages": [
        {"to": "01075640545"}
      ],
    });
    var url =
        "https://sens.apigw.ntruss.com/sms/v2/services/$serviceId/messages";
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'x-ncp-apigw-timestamp': timeStamp,
        'x-ncp-iam-access-key': accessKey,
        'x-ncp-apigw-signature-v2': sig,
      },
      body: msg,
    );
    if (response.statusCode == 202) {
      print('발송 완료.');
      return true;
    } else {
      print('에러가 발생했습니다.');
      return false;
    }
  }

  String getSignature(
      String serviceId, String timeStamp, String accessKey, String secretKey) {
    var space = " "; // one space
    var newLine = "\n"; // new line
    var method = "POST"; // method
    var url = "/sms/v2/services/$serviceId/messages";

    var buffer = StringBuffer();
    buffer.write(method);
    buffer.write(space);
    buffer.write(url);
    buffer.write(newLine);
    buffer.write(timeStamp);
    buffer.write(newLine);
    buffer.write(accessKey);
    print(buffer.toString());

    /// signing key
    var key = utf8.encode(secretKey);
    var signingKey = Hmac(sha256, key);

    var bytes = utf8.encode(buffer.toString());
    var digest = signingKey.convert(bytes);
    String signatureKey = base64.encode(digest.bytes);
    return signatureKey;
  }
}
