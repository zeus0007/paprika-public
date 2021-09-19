import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputText extends StatelessWidget {
  InputText(
      {this.controller,
      this.onChanged,
      @required this.keyboardType,
      this.maxLength,
      this.hintText,
      this.onSubmitted,
      @required this.autofocus,
      this.validator,
      this.inputFormatters});
  final TextEditingController controller;
  final Function onChanged;
  final TextInputType keyboardType;
  final int maxLength;
  final String hintText;
  final bool autofocus;
  final Function onSubmitted;
  final Function validator;
  final List<TextInputFormatter> inputFormatters;
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
        counterText: "",
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400], width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
    );
  }
}
