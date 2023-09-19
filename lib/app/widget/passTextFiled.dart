import 'package:flutter/material.dart';

import '../services/screenAdapter.dart';

class PassTextFiled extends StatelessWidget {
  final bool isPassword;
  final String hintText;
  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  const PassTextFiled(
      {super.key,
      required this.hintText,
      required this.textEditingController,
      this.keyboardType = TextInputType.phone,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      child: TextField(
        controller: textEditingController,
        keyboardType: keyboardType,
        obscureText: isPassword,
        decoration:
            InputDecoration(hintText: hintText, border: InputBorder.none),
      ),
    );
  }
}
