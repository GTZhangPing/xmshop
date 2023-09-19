import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/models/message.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/screenAdapter.dart';
import 'package:xmshop/app/widget/PassTextFiled.dart';
import 'package:xmshop/app/widget/logo.dart';
import 'package:xmshop/app/widget/passButton.dart';

import '../../../../widget/userAreement.dart';
import '../controllers/pass_login_controller.dart';

class PassLoginView extends GetView<PassLoginController> {
  const PassLoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [TextButton(onPressed: () {}, child: const Text('帮助'))],
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(40)),
        children: [
          const Logo(),
          PassTextFiled(
            hintText: '请输入手机号',
            textEditingController: controller.phoneController,
          ),
          SizedBox(height: ScreenAdapter.width(20)),
          PassTextFiled(
            hintText: '请输入密码',
            textEditingController: controller.passworldController,
          ),
          const UserAreement(),
          PassButton(
            text: '登录',
            onPressed: () async {
              if (!GetUtils.isPhoneNumber(controller.phoneController.text) ||
                  controller.phoneController.text.length != 11) {
                Get.snackbar('提示', '手机号不合法');
              } else if (controller.passworldController.text.length < 6) {
                Get.snackbar('提示', '密码必须大于6位');
              } else {
                MessageModel result = await controller.doLogin();
                if (result.success) {
                  Get.offAllNamed(Routes.TABS);
                } else {
                  Get.snackbar('提示', result.message);
                }
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: () {}, child: const Text("忘记密码")),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("验证码登录"))
            ],
          )
        ],
      ),
    );
  }
}
