import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/models/message.dart';
import 'package:xmshop/app/services/httpsClient.dart';

import '../../../../services/storage.dart';

class PassLoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passworldController = TextEditingController();

  HttpsClient httpsClient = HttpsClient();

  doLogin() async {
    var response = await httpsClient.post("api/doLogin", data: {
      "username": phoneController.text,
      "password": passworldController.text,
    });
    if (response != null) {
      if (response.data['success']) {
        Storage.setData("userinfo", response.data["userinfo"]);

        return MessageModel(message: '登录成功', success: true);
      } else {
        return MessageModel(message: response.data['message'], success: false);
      }
    } else {
      return MessageModel(message: '网络异常', success: false);
    }
  }
}
