import 'package:flutter/material.dart';

import 'constants.dart';

class StandardTextField extends StatelessWidget {
  const StandardTextField({
    @required this.icon,
    this.prefix = '',
    @required this.hintText,
    @required this.keyboardType,
    @required this.topBorders,
    @required this.maxLength,
    this.controller,
  });

  final IconData icon;
  final String prefix;
  final String hintText;
  final TextInputType keyboardType;
  final double topBorders;
  final int maxLength;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.88,
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topBorders),
              topRight: Radius.circular(topBorders)),
//          boxShadow: [kContainersShadow],
          color: kOGLightgrayBG),
      child: TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        keyboardType: keyboardType,
        maxLength: maxLength,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kThemeColor, width: 2)),
            counterText: "",
            isDense: true,
            prefix: Text(prefix),
            prefixIcon: Icon(icon, color: kThemeColor, size: 25),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14.5, color: kUnselected)),
      ),
    );
  }
}
