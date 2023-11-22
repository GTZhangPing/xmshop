import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/screenAdapter.dart';
import '../controllers/address_add_controller.dart';

class AddressAddView extends GetView<AddressAddController> {
  const AddressAddView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(controller.addressItemModel.sId != null ? '修改地址' : '新增地址'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: ScreenAdapter.width(20)),
        children: [
          Container(
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('姓名'),
                    SizedBox(
                      width: ScreenAdapter.width(40),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: controller.nameController,
                        decoration: InputDecoration(
                            hintText: '请输入姓名', border: InputBorder.none),
                      ),
                    )
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Text('电话'),
                    SizedBox(
                      width: ScreenAdapter.width(40),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: controller.phoneController,
                        decoration: InputDecoration(
                            hintText: '请输入电话', border: InputBorder.none),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenAdapter.height(40),
          ),
          Container(
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            child: Column(
              children: [
                Container(
                  height: ScreenAdapter.height(140),
                  child: InkWell(
                    onTap: () async {
                      Result? result = await CityPickers.showCityPicker(
                        context: context,
                      );
                      // print(result);
                      if (result != null) {
                        controller.area.value =
                            "${result.provinceName} ${result.cityName} ${result.areaName}";
                      }
                    },
                    child: Row(
                      children: [
                        Text('所在地区'),
                        SizedBox(
                          width: ScreenAdapter.width(40),
                        ),
                        Expanded(
                          flex: 1,
                          child: Obx(() => Text(controller.area.value)),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    Text('详细地址'),
                    SizedBox(
                      width: ScreenAdapter.width(40),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: controller.addressController,
                        decoration: InputDecoration(
                            hintText: '请输入详细地址', border: InputBorder.none),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: ScreenAdapter.height(200),
                ),
                Container(
                  // color: Colors.red,
                  padding: EdgeInsets.all(ScreenAdapter.height(20)),
                  height: ScreenAdapter.height(180),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.doAddAddress();
                    },
                    child: Text(
                        controller.addressItemModel.sId != null ? '修改' : '保存'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red),
                        foregroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
