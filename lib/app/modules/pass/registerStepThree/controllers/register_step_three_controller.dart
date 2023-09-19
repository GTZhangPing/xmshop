import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/models/message.dart';
import 'package:xmshop/app/services/httpsClient.dart';
import 'package:xmshop/app/services/storage.dart';

class RegisterStepThreeController extends GetxController {
  //TODO: Implement RegisterStepThreeController

  TextEditingController passworldController = TextEditingController();

  TextEditingController passworld2Controller = TextEditingController();

  String tel = Get.arguments['tel'];
  String code = Get.arguments["code"];

  HttpsClient httpsClient = HttpsClient();

  doRegister() async {
    Map data = {'tel': tel, 'code': code, 'password': passworldController.text};
    var response = await httpsClient.post('api/register', data: data);
    print(data);

    print(response);
    if (response != null) {
      if (response.data['success']) {
        Storage.setData('userinfo', response.data["userinfo"]);
        return MessageModel(message: '注册成功', success: true);
      } else {
        return MessageModel(message: 'message', success: false);
      }
    } else {
      return MessageModel(message: '网络异常', success: false);
    }
  }
}
