import 'package:flutter/material.dart';

import '../services/screenAdapter.dart';

class PassButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const PassButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.height(180),
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(Colors.orange),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)))),
          child: Text(
            text,
            style: TextStyle(fontSize: ScreenAdapter.fontSize(46)),
          ),),
    );
  }
}
