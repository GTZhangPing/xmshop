import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: PageView(children: controller.pages,
        controller: controller.pageController,
        physics: NeverScrollableScrollPhysics() /// 禁止滚动
        // onPageChanged: (index) {
        //   // controller.currentIndex.value = index;
        // },
        ),
        bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.red,
            currentIndex: controller.currentIndex.value,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              controller.currentIndex.value = index;
              controller.pageController.jumpToPage(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
              BottomNavigationBarItem(icon: Icon(Icons.category), label: '分类'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.room_service), label: '服务'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: '购物车'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: '用户'),
            ]),
      );
    });
  }
}
