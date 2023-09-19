import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/httpsClient.dart';
import 'package:xmshop/app/services/screenAdapter.dart';

import '../controllers/product_list_controller.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldGlobalKey,
      endDrawer: const Drawer(
        child: DrawerHeader(
          child: Text("右侧筛选"),
        ),
      ),
      appBar: AppBar(
        title: InkWell(
          child: Container(
          height: ScreenAdapter.height(96),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(ScreenAdapter.height(96 / 2)),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  color: Colors.black12,
                ),
              ),
              Text(
                controller.keywords ?? '',
                style: TextStyle(
                    color: Colors.black12,
                    fontSize: ScreenAdapter.fontSize(50)),
              ),
            ],
          ),
        ),
        onTap: () {
          Get.offAndToNamed(Routes.SEARCH);
          // Get.toNamed(Routes.SEARCH);
        },
        ),
        actions: const [Text('')],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          _productListWidget(),
          _subHeaderWidget(),
        ],
      ),
    );
  }

  Widget _subHeaderWidget() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Obx(() => Container(
            height: ScreenAdapter.height(120),
            width: ScreenAdapter.getScreenWidth(),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        width: ScreenAdapter.height(2),
                        color: const Color.fromRGBO(233, 233, 233, 0.9)))),
            child: Row(
              children: controller.subHeaderList.map((value) {
                return Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${value["title"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: controller.selectHeaderId == value["id"]
                                  ? Colors.red
                                  : Colors.black54,
                              fontSize: ScreenAdapter.fontSize(32)),
                        ),
                        _showIcon(value['id'])
                      ],
                    ),
                    onTap: () {
                      controller.subHeaderChange(value['id']);
                    },
                  ),
                );
              }).toList(),
            ),
          )),
    );
  }

  //自定义箭头组件
  Widget _showIcon(id) {
    //controller.subHeaderListSort 作用 : 响应式状态  为了改变状态
    if (id == 2 || id == 3) {
      if (controller.subHeaderListSort.value == 1 ||
          controller.subHeaderListSort.value == -1) {
        if (controller.subHeaderList[id - 1]["sort"] == 1) {
          return const Icon(Icons.arrow_drop_down, color: Colors.black54);
        } else {
          return const Icon(Icons.arrow_drop_up, color: Colors.black54);
        }
      }
      return const Icon(Icons.arrow_drop_up, color: Colors.black54);
    } else {
      return const Text("");
    }
  }

  Widget _productListWidget() {
    return Obx(() {
      return controller.plist.isEmpty
          ? _progressIndicator()
          : ListView.builder(
              controller: controller.scrollController,
              padding: EdgeInsets.fromLTRB(
                  ScreenAdapter.width(30),
                  ScreenAdapter.height(140),
                  ScreenAdapter.width(30),
                  ScreenAdapter.height(20)),
              itemCount: controller.plist.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: ScreenAdapter.height(26)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(ScreenAdapter.width(60)),
                            width: ScreenAdapter.width(400),
                            height: ScreenAdapter.height(460),
                            child: Image.network(
                                "${HttpsClient.replaeUri(controller.plist[index].sPic)}",
                                fit: BoxFit.fitHeight),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: ScreenAdapter.height(20)),
                                  child: Text(
                                    '${controller.plist[index].title}',
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.fontSize(42),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: ScreenAdapter.height(20)),
                                  child: Text(
                                    '${controller.plist[index].subTitle}',
                                    style: TextStyle(
                                      fontSize: ScreenAdapter.fontSize(34),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: ScreenAdapter.height(20)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text("CUP",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            34),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text("Helio G25",
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenAdapter.fontSize(
                                                          34),
                                                ))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text("高清拍摄",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            34),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text("1300万像素",
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenAdapter.fontSize(
                                                          34),
                                                ))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text("超大屏",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            34),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text("6.1寸",
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenAdapter.fontSize(
                                                          34),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text("￥${controller.plist[index].price}起",
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.fontSize(38),
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    (index == controller.plist.length - 1)
                        ? _progressIndicator()
                        : const SizedBox(
                            height: 0.1,
                          ),
                  ],
                );
              },
            );
    });
  }

  Widget _progressIndicator() {
    return Center(
        child: controller.hasData.value
            ? const CircularProgressIndicator()
            : const Text('没有数据了哦，我是有底线的'));
  }
}
