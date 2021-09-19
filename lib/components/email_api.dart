import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:opena_front/config.dart';

class EmailApi {
  Future sendEmail() async {
    String timeStamp = (DateTime.now().millisecondsSinceEpoch).toString();
    String accessKey = ACCESSKEY;
    String secretKey = SECRETKEY;

    String sig = getSignature(timeStamp, accessKey, secretKey);
    final msg = jsonEncode({
      "templateSid": "2093",
      "recipients": [
        {
          "address": "wpdn79@naver.com",
          "name": "김제우",
          "type": "R",
          "parameters": {"CERT_NUMBER": "123123"}
        }
      ],
      "useBasicUnsubscribeMsg	": "true",
    });
    var url = "https://mail.apigw.ntruss.com/api/v1/mails";
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
    if (response.statusCode == 201 || response.statusCode == 202) {
      print('발송 완료.');
      return true;
    } else {
      print(response.statusCode);
      print('에러가 발생했습니다.');
      return false;
    }
  }

  String getSignature(String timeStamp, String accessKey, String secretKey) {
    var space = " "; // one space
    var newLine = "\n"; // new line
    var method = "POST"; // method
    var url = "/api/v1/mails";

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
