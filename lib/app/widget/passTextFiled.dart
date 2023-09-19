import 'package:flutter/material.dart';

import '../services/screenAdapter.dart';

class PassTextFiled extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  const PassTextFiled({super.key, required this.hintText, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      child: TextField(
        controller: textEditingController,
        decoration:
            InputDecoration(hintText: hintText, border: InputBorder.none),
      ),
    );
  }
}
