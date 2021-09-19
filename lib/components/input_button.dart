import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  InputButton({this.color, this.needSplash, this.onPressed, this.child});
  final Color color;
  final bool needSplash;
  final Function onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Material(
        elevation: 0.0,
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
          splashColor: needSplash ? null : Colors.transparent,
          highlightColor: needSplash ? null : Colors.transparent,
          onPressed: onPressed,
          height: 40.0,
          child: child,
        ),
      ),
    );
  }
}
