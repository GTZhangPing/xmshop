import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/models/message.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/widget/PassTextFiled.dart';
import 'package:xmshop/app/widget/logo.dart';
import 'package:xmshop/app/widget/passButton.dart';

import '../../../../services/screenAdapter.dart';
import '../../../../widget/userAreement.dart';
import '../controllers/code_login_step_one_controller.dart';

class CodeLoginStepOneView extends GetView<CodeLoginStepOneController> {
  const CodeLoginStepOneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(onPressed: () {}, child: const Text('帮助')),
        ],
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(40)),
        children: [
          const Logo(),
          PassTextFiled(
            hintText: '请输入手机号',
            textEditingController: controller.textEditingController,
          ),
          const UserAreement(),
          PassButton(
            text: '获取验证码',
            onPressed: () async {
              if (!GetUtils.isPhoneNumber(
                      controller.textEditingController.text) &&
                  controller.textEditingController.text.length != 11) {
                Get.snackbar('提示', '手机号不合法');
              } else {
                MessageModel result = await controller.sendCode();
                if (result.success) {
                  Get.toNamed(Routes.CODE_LOGIN_STEP_TWO, arguments: {
                    'tel': controller.textEditingController.text
                  });
                } else {
                  Get.snackbar("提示信息!", result.message);
                }
              }
            },
          ),
          Container(
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.REGISTER_STEP_ONE);
                    },
                    child: const Text('新用户注册')),
                TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.PASS_LOGIN);
                    },
                    child: const Text('账号密码登录')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
