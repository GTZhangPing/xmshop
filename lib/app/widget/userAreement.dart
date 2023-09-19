import 'package:flutter/material.dart';

import '../services/screenAdapter.dart';

class UserAreement extends StatelessWidget {
  const UserAreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                const Text("意阅读并同意"),
                const Text(
                  "《商城用户协议》",
                  style: TextStyle(color: Colors.red),
                ),
                const Text(
                  "《商城用户协议》",
                  style: TextStyle(color: Colors.red),
                ),
                const Text("《商城隐私协议》", style: TextStyle(color: Colors.red)),
              ],
            ),
          );
  }
}