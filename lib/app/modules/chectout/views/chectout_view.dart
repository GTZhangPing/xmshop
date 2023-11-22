import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/httpsClient.dart';

import '../../../services/screenAdapter.dart';
import '../controllers/chectout_controller.dart';

class ChectoutView extends GetView<ChectoutController> {
  const ChectoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        title: const Text('确认订单'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [_body(), _bottom()],
      ),
    );
  }

  _body() {
    return ListView(
      padding: EdgeInsets.all(ScreenAdapter.height(40)),
      children: [
        Obx(
          () => controller.addressList.isEmpty
              ? Container(
                  padding: EdgeInsets.only(
                      top: ScreenAdapter.width(40),
                      bottom: ScreenAdapter.width(40)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.width(10)),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.add_location),
                    title: Text('添加地址'),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Get.toNamed(Routes.ADDRESS_LIST);
                    },
                  ),
                )
              : Container(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdapter.height(40), 0, ScreenAdapter.height(40)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.width(10)),
                  ),
                  child: ListTile(
                    onTap: () {
                      Get.toNamed(Routes.ADDRESS_LIST);
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${controller.addressList[0].name} ${controller.addressList[0].phone}"),
                        SizedBox(
                          height: ScreenAdapter.height(20),
                        ),
                        Text("${controller.addressList[0].address}"),
                      ],
                    ),
                    trailing: Icon(Icons.navigate_next),
                  ),
                ),
        ),
        SizedBox(
          height: ScreenAdapter.height(40),
        ),
        Container(
          padding: EdgeInsets.only(
              top: ScreenAdapter.height(20), bottom: ScreenAdapter.height(20)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(20))),
          child: Obx(() => controller.checkoutList.isNotEmpty
              ? Column(
                  children: controller.checkoutList.map((element) {
                    return _checkoutItem(element);
                  }).toList(),
                )
              : Text('')),
        ),
        SizedBox(
          height: ScreenAdapter.height(40),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(
              0, ScreenAdapter.height(20), 0, ScreenAdapter.height(20)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenAdapter.width(10)),
          ),
          child: const Column(
            children: [
              ListTile(
                leading: Text('运费'),
                trailing: Wrap(
                  children: [Text('包邮')],
                ),
              ),
              ListTile(
                title: Text('优惠券'),
                trailing: Wrap(
                  children: [Text('无可用'), Icon(Icons.navigate_next)],
                ),
              ),
              ListTile(
                title: Text('礼品卡'),
                trailing: Wrap(
                  children: [Text('无可用'), Icon(Icons.navigate_next)],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: ScreenAdapter.height(40),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenAdapter.width(10)),
          ),
          child: const ListTile(
            title: Text('发票'),
            trailing: Wrap(
              children: [Text('电子发票'), Icon(Icons.navigate_next)],
            ),
          ),
        ),
      ],
    );
  }

  _bottom() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.fromLTRB(ScreenAdapter.width(40),
            ScreenAdapter.height(20), ScreenAdapter.width(40), 0),
        height: ScreenAdapter.height(200),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
                color: const Color.fromARGB(178, 240, 236, 236),
                width: ScreenAdapter.height(2)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Obx(
                  () => Text("共${controller.allNum}件,合计:"),
                ),
                SizedBox(
                  width: ScreenAdapter.width(20),
                ),
                Obx(() => Text(
                      '${controller.allPrice}',
                      style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(58),
                          color: Colors.red),
                    )),
              ],
            ),
            SizedBox(
              width: ScreenAdapter.width(300),
              height: ScreenAdapter.width(100),
              child: ElevatedButton(
                onPressed: () {
                  controller.doCheckOut();
                },
                child: Text('去付款'),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(251, 72, 5, 0.9)),
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _checkoutItem(element) {
    return Container(
      padding: EdgeInsets.all(ScreenAdapter.height(20)),
      child: Row(
        children: [
          Container(
            width: ScreenAdapter.width(200),
            height: ScreenAdapter.width(200),
            child: Image.network(
              HttpsClient.replaeUri(element['pic']),
              fit: BoxFit.fitHeight,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${element['title']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: ScreenAdapter.height(10),
                ),
                Text('${element['selectedAttr']}'),
                SizedBox(
                  height: ScreenAdapter.height(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '¥${element['price']}',
                      style: TextStyle(color: Colors.red),
                    ),
                    Text('x${element['count']}'),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
