import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/modules/user/controllers/user_controller.dart';
import 'package:xmshop/app/services/storage.dart';
import '../../../../models/message.dart';
import '../../../../services/httpsClient.dart';

class CodeLoginStepTwoController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  String tel = Get.arguments["tel"];
  HttpsClient httpsClient = HttpsClient();
  RxInt count = 10.obs;
  UserController userController = Get.find();

  @override
  void onInit() {
    super.onInit();
    countDown();
  }

  @override
  void onClose() {
    super.onClose();
    userController.getUserInfo();
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
    var response =
        await httpsClient.post("api/sendLoginCode", data: {"tel": tel});
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

  doLogin() async {
    var response = await httpsClient.post("api/validateLoginCode",
        data: {"tel": tel, "code": textEditingController.text});
    print(response);
    if (response != null) {
      if (response.data['success']) {
        Storage.setData('userinfo', response.data['userinfo']);
        return MessageModel(message: "登录成功", success: true);
      } else {
        return MessageModel(message: response.data['message'], success: false);
      }
    } else {
      return MessageModel(message: "网络异常", success: false);
    }
  }
}
