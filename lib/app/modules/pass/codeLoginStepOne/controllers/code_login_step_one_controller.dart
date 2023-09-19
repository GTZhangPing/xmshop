import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/models/message.dart';
import 'package:xmshop/app/services/httpsClient.dart';

class CodeLoginStepOneController extends GetxController {
  //TODO: Implement CodeLoginStepOneController

  TextEditingController textEditingController = TextEditingController();
  HttpsClient httpsClient = HttpsClient();

  sendCode() async {
    var response = await httpsClient
        .post("api/sendLoginCode", data: {"tel": textEditingController.text});
    print(response);
    if (response != null) {
      if (response.data['success']) {
        Clipboard.setData(ClipboardData(text: response.data["code"]));

        return MessageModel(message: "发送验证码成功", success: true);
      } else {
        return MessageModel(message: response.data['message'], success: false);
      }
    } else {
      return MessageModel(message: "网络异常", success: false);
    }
  }
}
