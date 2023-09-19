import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/services/httpsClient.dart';

import '../../../../models/message.dart';

class RegisterStepTwoController extends GetxController {
  //TODO: Implement RegisterStepTwoController

  TextEditingController textEditingController = TextEditingController();

  HttpsClient httpsClient = HttpsClient();
  String tel = Get.arguments["tel"];

  RxInt count = 10.obs;

  @override
  void onInit() {
    super.onInit();
    countDown();
  }

  countDown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      count.value--;
      if (count.value == 0) {
        timer.cancel();
      }
      update();
    });
  }

  sendCode() async {
    var response = await httpsClient.post("api/sendCode", data: {"tel": tel});

    print(response);
    if (response != null) {
      if (response.data['success']) {
        Clipboard.setData(ClipboardData(text: response.data["code"]));
        count.value = 10;
        countDown();
        update();
        return MessageModel(message: "发送验证码成功", success: true);
      } else {
        return MessageModel(message: response.data['message'], success: false);
      }
    } else {
      return MessageModel(message: "网络异常", success: false);
    }
  }
//验证验证码
  Future<bool> validateCode() async {
    var response = await httpsClient.post("api/validateCode", data: {
      "tel": tel, //上一个页面穿过来的手机号
      "code": textEditingController.text
    });
        print(textEditingController.text+tel);

    print(response);
    if (response != null) {
      if (response.data["success"]) {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }
}
