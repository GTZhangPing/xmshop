import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/screenAdapter.dart';

import '../controllers/address_list_controller.dart';

class AddressListView extends GetView<AddressListController> {
  const AddressListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('收获地址'),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Obx(
            () => controller.addressList.isNotEmpty
                ? ListView(
                    padding: EdgeInsets.all(ScreenAdapter.height(20)),
                    children: controller.addressList
                        .map((element) => Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    controller
                                        .changeDefalutAddress(element.sId);
                                  },
                                  onLongPress: () {
                                    if (element.defaultAddress != 1) {
                                      Get.defaultDialog(
                                          title: '提示',
                                          middleText: '确认删除该地址吗？',
                                          confirm: TextButton(
                                              onPressed: () {
                                                controller
                                                    .deleteAddress(element.sId);
                                                Get.back();
                                              },
                                              child: Text('确定')),
                                          cancel: TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text('取消')));
                                    }
                                  },
                                  leading: element.defaultAddress == 1
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.red,
                                        )
                                      : null,
                                  trailing: IconButton(
                                      onPressed: () {
                                        Map json = element.toJson();
                                        // Map tempJson = {
                                        //   'name': 'nameController.text',
                                        //   'phone': 'phoneController.text',
                                        //   'uid': 'userInfo.sId',
                                        //   'address': "{addressController.text}",
                                        // };
                                        print(json);
                                        // print(tempJson);

                                        Get.toNamed(Routes.ADDRESS_ADD,
                                            arguments: json);
                                      },
                                      icon: const Icon(Icons.edit)),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${element.address}'),
                                      SizedBox(
                                        height: ScreenAdapter.height(20),
                                      ),
                                      Text("${element.name} ${element.phone}"),
                                    ],
                                  ),
                                ),
                                Divider()
                              ],
                            ))
                        .toList(),
                  )
                : ListView(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: ScreenAdapter.height(210),
              padding: EdgeInsets.fromLTRB(
                  ScreenAdapter.width(40),
                  ScreenAdapter.width(20),
                  ScreenAdapter.width(40),
                  ScreenAdapter.width(60)),
              color: Colors.white,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.ADDRESS_ADD);
                },
                child: Text('新建收货地址'),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                    foregroundColor: MaterialStatePropertyAll(Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
