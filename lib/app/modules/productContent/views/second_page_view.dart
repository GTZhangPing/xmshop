import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/modules/productContent/controllers/product_content_controller.dart';

// ignore: must_be_immutable
class SecondPageView extends GetView {
  Widget subHeader;
  SecondPageView(this.subHeader, {Key? key}) : super(key: key);
  @override
  ProductContentController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.gk2,
      child: Column(children: [
        subHeader,
        Obx(
          () => SizedBox(
            child: Html(
                data: controller.selectedSubTabsIndex.value == 1
                    ? controller.pcontent.value.content ?? ''
                    : controller.pcontent.value.specs ?? ''),
          ),
        ),
      ]),
    );
  }
}
