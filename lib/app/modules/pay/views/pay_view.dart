import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/screenAdapter.dart';
import 'package:xmshop/app/widget/passButton.dart';

import '../controllers/pay_controller.dart';

class PayView extends GetView<PayController> {
  const PayView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('去支付'),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(
          padding: EdgeInsets.all(ScreenAdapter.width(40)),
          children: [
            Obx(
              () => Column(
                children: controller.payList.map((value) {
                  return ListTile(
                    onTap: () {
                      controller.changePayList(value['title']);
                    },
                    leading: SizedBox(
                      width: ScreenAdapter.width(100),
                      height: ScreenAdapter.height(100),
                      child: Image.network(value['image']),
                    ),
                    title: Text(value['title']),
                    trailing: value['chekced'] ? Icon(Icons.check) : null,
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: ScreenAdapter.height(200),
            ),
            PassButton(
              text: '支付',
              onPressed: () {
                Get.toNamed(Routes.ORDER_LIST);
              },
            )
          ],
        ));
  }
}
