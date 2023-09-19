import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/models/message.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/screenAdapter.dart';
import 'package:xmshop/app/widget/logo.dart';
import 'package:xmshop/app/widget/passTextFiled.dart';

import '../../../../widget/passButton.dart';
import '../controllers/register_step_one_controller.dart';

class RegisterStepOneView extends GetView<RegisterStepOneController> {
  const RegisterStepOneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('手机号快速注册'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(40)),
        children: [
          const Logo(),
          PassTextFiled(
            hintText: '请输入手机号',
            textEditingController: controller.phoneController,
          ),
          SizedBox(height: ScreenAdapter.height(40)),
          PassButton(
            text: '下一步',
            onPressed: () async {
              if (!GetUtils.isPhoneNumber(controller.phoneController.text) ||
                  controller.phoneController.text.length != 11) {
                Get.snackbar('提示', '手机号不合法');
              } else {
                MessageModel result = await controller.sendCode();
                if (result.success) {
                  Get.toNamed(Routes.REGISTER_STEP_TWO, arguments: {'tel': controller.phoneController.text});
                } else {
                  Get.snackbar('提示', result.message);
                }
              }
            },
          ),
          SizedBox(height: ScreenAdapter.height(40)),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("遇到问题？您可以"),
                TextButton(
                    onPressed: () {
                      print("获取帮助");
                    },
                    child: const Text("获取帮助"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
