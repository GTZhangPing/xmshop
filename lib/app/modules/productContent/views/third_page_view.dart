import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/modules/productContent/controllers/product_content_controller.dart';

import '../../../services/screenAdapter.dart';

// ignore: must_be_immutable
class ThirdPageView extends GetView {
 ThirdPageView({Key? key}) : super(key: key);
  @override
  ProductContentController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
            key: controller.gk3,
            height: ScreenAdapter.height(4400),
            color: Colors.blue,
          );
  }
}
