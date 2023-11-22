import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/httpsClient.dart';
import 'package:xmshop/app/services/screenAdapter.dart';

import '../controllers/order_list_controller.dart';

class OrderListView extends GetView<OrderListController> {
  const OrderListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getOrderList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('订单列表'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Obx(() => controller.orderList.isNotEmpty
              ? ListView(
                  padding: EdgeInsets.fromLTRB(
                      ScreenAdapter.width(40),
                      ScreenAdapter.width(180),
                      ScreenAdapter.width(40),
                      ScreenAdapter.width(40)),
                  children: controller.orderList
                      .map((element) => Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.grey[200]!,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Routes.ORDER_DETAIL,
                                  arguments: {"id": element.sId});
                            },
                            child: Column(children: [
                              ListTile(
                                title: Text('订单编号：${element.orderId}'),
                              ),
                              ...element.orderItem!
                                  .map(
                                    (e) => ListTile(
                                      leading: Container(
                                          alignment: Alignment.center,
                                          width: ScreenAdapter.width(120),
                                          height: ScreenAdapter.height(120),
                                          child: Image.network(
                                              HttpsClient.replaeUri(
                                                  e.productImg))),
                                      title: Text('${e.productTitle}'),
                                      trailing: Text('x${e.productCount}'),
                                    ),
                                  )
                                  .toList(),
                              ListTile(
                                title: Wrap(
                                  children: [
                                    const Text('合计：'),
                                    Text('${element.allPrice}')
                                  ],
                                ),
                                trailing: TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey[200])),
                                  child: const Text("申请售后"),
                                ),
                              )
                            ]),
                          )))
                      .toList(),
                )
              : const Center(
                  child: Text('暂无订单'),
                )),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              height: ScreenAdapter.height(140),
              child: const Row(
                children: [
                  Expanded(
                    child: Text("全部", textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text("待付款", textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text("待收货", textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text("已完成", textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text("已取消", textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
