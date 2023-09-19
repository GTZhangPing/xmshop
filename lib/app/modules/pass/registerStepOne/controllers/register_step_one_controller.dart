import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../models/message.dart';
import '../../../../services/httpsClient.dart';

class RegisterStepOneController extends GetxController {
  //TODO: Implement RegisterStepOneController

  TextEditingController phoneController = TextEditingController();
  HttpsClient httpsClient = HttpsClient();

  sendCode() async {
    var response = await httpsClient
        .post("api/sendCode", data: {"tel": phoneController.text});
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
