import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/widget/logo.dart';

import '../../../../services/screenAdapter.dart';
import '../controllers/register_step_two_controller.dart';

class RegisterStepTwoView extends GetView<RegisterStepTwoController> {
  const RegisterStepTwoView({Key? key}) : super(key: key);
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
          Container(
            child: Column(
              children: [
                const Text("请输入验证码",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: ScreenAdapter.height(20)),
                const Text("已发送至 ")
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenAdapter.height(60)),
            padding: EdgeInsets.all(ScreenAdapter.width(40)),
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              autoFocus: true, //进入就弹出键盘
              keyboardType: TextInputType.number, //调用数字键盘
              obscureText: false,
              animationType: AnimationType.fade,
              controller: controller.textEditingController,
              dialogConfig: DialogConfig(
                  //汉化dialog
                  dialogTitle: "黏贴验证码",
                  dialogContent: "确定要黏贴验证码",
                  affirmativeText: "确定",
                  negativeText: "取消"), //配置dialog
              pinTheme: PinTheme(
                //样式12
                // 修改边框
                activeColor: Colors.black12, // 输入文字后边框的颜色
                selectedColor: Colors.orange, // 选中边框的颜色
                inactiveColor: Colors.black12, //默认的边框颜色
                //背景颜色
                activeFillColor: Colors.white,
                selectedFillColor: Colors.orange,
                inactiveFillColor: const Color.fromRGBO(245, 245, 245, 1),

                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,

              onChanged: (value) {},
              onCompleted: (value) async {
                bool result = await controller.validateCode();
                if (result) {
                  Get.toNamed(Routes.REGISTER_STEP_THREE, arguments: {
                    'tel': controller.tel,
                    'code': controller.textEditingController.text
                  });
                } else {
                  Get.snackbar('提示', "验证码输入错误" );
                }
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () {
                  if (controller.count.value == 0) {
                    controller.sendCode();
                  }
                }, child: Obx(() {
                  return controller.count.value > 0 ? Text("${controller.count.value}秒后发送验证码") : const Text("重新发送验证码");
                }) ),
                TextButton(onPressed: () {}, child: const Text("帮助")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
