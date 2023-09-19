import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/models/message.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/screenAdapter.dart';
import 'package:xmshop/app/widget/PassTextFiled.dart';
import 'package:xmshop/app/widget/logo.dart';
import 'package:xmshop/app/widget/passButton.dart';

import '../controllers/register_step_three_controller.dart';

class RegisterStepThreeView extends GetView<RegisterStepThreeController> {
  const RegisterStepThreeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text("手机号快速注册"),
        actions: [TextButton(onPressed: () {}, child: const Text("帮助"))],
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(40)),
        children: [
          const Logo(),
          PassTextFiled(
            hintText: "请输入密码",
            textEditingController: controller.passworldController,
          ),
          SizedBox(height: ScreenAdapter.height(20)),
          PassTextFiled(
            hintText: "输入确认密码",
            textEditingController: controller.passworld2Controller,
          ),
          SizedBox(height: ScreenAdapter.height(20)),
          PassButton(
            text: '完成注册',
            onPressed: () async {
              if (controller.passworldController.text.length < 6) {
                Get.snackbar('提示', '密码不能小于6位');
              } else if (controller.passworld2Controller.text !=
                  controller.passworldController.text) {
                Get.snackbar('提示', '密码不一致');
              } else {
                MessageModel result = await controller.doRegister();
                if (result.success) {
                  Get.snackbar('提示', '注册成功');
                  Get.offAllNamed(Routes.TABS);
                } else {
                  Get.snackbar('提示', result.message);
                }
              }
            },
          )
        ],
      ),
    );
  }
}
