import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/modules/productContent/views/first_page_view.dart';
import 'package:xmshop/app/modules/productContent/views/second_page_view.dart';
import 'package:xmshop/app/modules/productContent/views/third_page_view.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/screenAdapter.dart';
import '../controllers/product_content_controller.dart';
import 'cart_item_num_view.dart';

class ProductContentView extends GetView<ProductContentController> {
  const ProductContentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //实现透明导航
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ScreenAdapter.height(120)),
        child: _appBar(context),
      ),
      body: Stack(
        children: [
          _body(),
          _bottom(),
          Obx(() => controller.showSubHeaderTabs.value
              ? Positioned(
                  left: 0,
                  right: 0,
                  top: ScreenAdapter.getStatusBarHeight() +
                      ScreenAdapter.height(120),
                  child: _subHeader())
              : const Text('')),
        ],
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Obx(
      () => AppBar(
        backgroundColor: Colors.white.withOpacity(controller.opacity.value),
        elevation: 0,
        title: controller.showTabs.value
            ? SizedBox(
                height: ScreenAdapter.height(120),
                width: ScreenAdapter.width(400),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: controller.tabsList.map((value) {
                    return InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            value['title'],
                            style: TextStyle(
                              fontSize: ScreenAdapter.fontSize(40),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            color: controller.selectedTabsIndex.value ==
                                    value['id']
                                ? Colors.red
                                : Colors.white,
                            width: ScreenAdapter.width(70),
                            height: ScreenAdapter.height(4),
                          )
                        ],
                      ),
                      onTap: () {
                        controller.changeSelectedTabsIndex(value['id']);
                        if (value['id'] == 1) {
                          Scrollable.ensureVisible(
                              controller.gk1.currentContext as BuildContext,
                              duration: const Duration(milliseconds: 100));
                        } else if (value['id'] == 2) {
                          Scrollable.ensureVisible(
                              controller.gk2.currentContext as BuildContext,
                              duration: const Duration(milliseconds: 100));
                          Timer(const Duration(milliseconds: 100), () {
                            controller.scrollController.jumpTo(
                                controller.scrollController.position.pixels -
                                    ScreenAdapter.height(120));
                          });
                        } else {
                          Scrollable.ensureVisible(
                              controller.gk3.currentContext as BuildContext,
                              duration: const Duration(milliseconds: 100));
                          Timer(const Duration(milliseconds: 100), () {
                            controller.scrollController.jumpTo(
                                controller.scrollController.position.pixels -
                                    ScreenAdapter.height(120));
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
              )
            : const Text(''),
        centerTitle: true,
        leading: Container(
          alignment: Alignment.center,
          child: SizedBox(
            width: ScreenAdapter.width(88),
            height: ScreenAdapter.height(88),
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                shape: MaterialStateProperty.all(const CircleBorder()),
                backgroundColor: MaterialStateProperty.all(Colors.black12),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
            width: ScreenAdapter.width(88),
            height: ScreenAdapter.height(88),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                shape: MaterialStateProperty.all(const CircleBorder()),
                backgroundColor: MaterialStateProperty.all(Colors.black12),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Icon(Icons.file_upload_outlined),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
            width: ScreenAdapter.width(88),
            height: ScreenAdapter.height(88),
            child: ElevatedButton(
              onPressed: () {
                showMenu(
                    color: Colors.black87.withOpacity(0.7),
                    context: context,
                    position: RelativeRect.fromLTRB(
                        ScreenAdapter.width(10000),
                        ScreenAdapter.height(300),
                        ScreenAdapter.width((30)),
                        0),
                    items: [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: ScreenAdapter.width(20),
                            ),
                            const Text(
                              '首页',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: ScreenAdapter.width(20),
                            ),
                            const Text(
                              '消息',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: ScreenAdapter.width(20),
                            ),
                            const Text(
                              '收藏',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ]);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                shape: MaterialStateProperty.all(const CircleBorder()),
                backgroundColor: MaterialStateProperty.all(Colors.black12),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Icon(Icons.more_horiz_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Column(
        children: [
          FirstPageView(showBottomAttr),
          SecondPageView(_subHeader()),
          ThirdPageView(),
        ],
      ),
    );
  }

  Widget _bottom() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        height: ScreenAdapter.height(200),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.CART);
              },
              child: Container(
              width: ScreenAdapter.width(230),
              height: ScreenAdapter.height(160),
              color: Colors.white,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart),
                  Text('购物车'),
                ],
              ),
            ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(right: 20),
                height: ScreenAdapter.height(120),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(255, 165, 0, 0.9)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
                  onPressed: () {
                    showBottomAttr(2);
                  },
                  child: const Text('加入购物车'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(right: 20),
                height: ScreenAdapter.height(120),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(253, 1, 0, 0.9)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
                  onPressed: () {
                    showBottomAttr(3);
                  },
                  child: const Text('立即购买'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //bottomSheet更新流数据需要使用 GetBuilder 来渲染数据
  //action 1点击的是筛选属性   2 点击的是加入购物车   3 表示点击的是立即购买
  showBottomAttr(int action) {
    Get.bottomSheet(
      GetBuilder<ProductContentController>(
        init: controller,
        builder: (controller) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            height: ScreenAdapter.height(1200),
            child: Stack(
              children: [
                ListView(children: [
                  ...controller.pcontent.value.attr!.map((v) {
                    return Wrap(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: ScreenAdapter.height(20),
                              left: ScreenAdapter.width(20)),
                          width: ScreenAdapter.width(1040),
                          child: Text("${v.cate}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: ScreenAdapter.height(20),
                              left: ScreenAdapter.width(20)),
                          child: Wrap(
                            children: v.list!.asMap().entries.map(
                              (entrie) {
                                var value = entrie.value;
                                return InkWell(
                                  onTap: () {
                                    controller.changeAttr(v.cate, entrie.key);
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.all(ScreenAdapter.width(20)),
                                    child: Chip(
                                        padding: EdgeInsets.only(
                                            left: ScreenAdapter.width(20),
                                            right: ScreenAdapter.width(20)),
                                        backgroundColor:
                                            v.checkList![entrie.key] == true
                                                ? Colors.red
                                                : const Color.fromARGB(
                                                    31, 223, 213, 213),
                                        label: Text(value)),
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  Padding(
                    padding: EdgeInsets.all(ScreenAdapter.height(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("数量",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        CartItemNumView(),
                      ],
                    ),
                  )
                ]),
                Positioned(
                    top: 0,
                    right: 2,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close))),
                Positioned(
                    left: ScreenAdapter.width(20),
                    right: ScreenAdapter.width(20),
                    bottom: 0,
                    child: action == 1
                        ? Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: ScreenAdapter.height(120),
                                    margin: EdgeInsets.only(
                                        right: ScreenAdapter.width(20),
                                        bottom: ScreenAdapter.height(40)),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          controller.addCart();
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color.fromRGBO(
                                                        255, 165, 0, 0.9)),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)))),
                                        child: const Text('加入购物车')),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: ScreenAdapter.height(120),
                                    margin: EdgeInsets.only(
                                        right: ScreenAdapter.width(20),
                                        bottom: ScreenAdapter.height(40)),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color.fromRGBO(
                                                        253, 1, 0, 0.9)),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)))),
                                        onPressed: () {
                                          controller.buy();
                                        },
                                        child: const Text('立即购买')),
                                  )),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: ScreenAdapter.height(120),
                                    margin: EdgeInsets.only(
                                        right: ScreenAdapter.width(20),
                                        bottom: ScreenAdapter.height(40)),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color.fromRGBO(
                                                        253, 1, 0, 0.9)),
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)))),
                                        onPressed: () {
                                          action == 2 ? controller.addCart() : controller.buy();
                                        },
                                        child: const Text('确定')),
                                  )),
                            ],
                          )),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _subHeader() {
    return Obx(
      () => Container(
        color: Colors.white,
        child: Row(
          children: controller.subTabsList
              .map(
                (value) => Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.changeSelectedSubTabsIndex(value['id']);
                    },
                    child: Container(
                      height: ScreenAdapter.height(120),
                      alignment: Alignment.center,
                      child: Text(value['title'],
                          style: TextStyle(
                              color: controller.selectedSubTabsIndex.value ==
                                      value['id']
                                  ? Colors.red
                                  : Colors.black87)),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

 
}
