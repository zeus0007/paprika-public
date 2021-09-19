import 'package:flutter/material.dart';
import 'package:opena_front/constants.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:flutter/services.dart';

class CertTextInputBox extends StatelessWidget {
  CertTextInputBox(
      {@required this.kContentsTextFieldLabel,
      this.onChanged,
      this.autofocus = true});
  final Function onChanged;
  final TextStyle kContentsTextFieldLabel;
  final bool autofocus;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 315,
          height: 20,
          child: TextField(
            textAlign: TextAlign.end,
            textAlignVertical: TextAlignVertical.bottom,
            style: TextStyle(
              color: Color(0xFF212428),
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
            keyboardType: TextInputType.number,
            maxLength: 13,
            cursorColor: Color(0xFFAEAEB2),
            cursorHeight: 16,
            autofocus: autofocus,
            onChanged: onChanged,
            inputFormatters: [ThousandsFormatter()],
            decoration: InputDecoration(
              counterText: "",
              suffixText: '원',
              suffixStyle: kBlackRegular15,
              contentPadding: EdgeInsets.symmetric(vertical: 9),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD1D1D6), width: 2.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD1D1D6), width: 2.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xE0565757), width: 2.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
