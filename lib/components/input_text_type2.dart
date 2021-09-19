import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputText2 extends StatelessWidget {
  InputText2({
    this.controller,
    this.onChanged,
    @required this.keyboardType,
    this.maxLength,
    this.hintText,
    this.onSubmitted,
    @required this.autofocus,
    this.validator,
    this.inputFormatters,
    this.isMoney = false,
  });
  final TextEditingController controller;
  final Function onChanged;
  final TextInputType keyboardType;
  final int maxLength;
  final String hintText;
  final bool autofocus;
  final Function onSubmitted;
  final Function validator;
  final List<TextInputFormatter> inputFormatters;
  final bool isMoney;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      onChanged: onChanged,
      autofocus: autofocus,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        filled: true,
        fillColor: Colors.white,
        suffixText: isMoney ? '만원' : '',
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFED3B43), width: 2.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFED3B43), width: 2.0),
        ),
        enabledBorder: InputBorder.none,
      ),
    );
  }
}
