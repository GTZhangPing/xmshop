import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/models/address_model.dart';
import 'package:xmshop/app/models/user_model.dart';
import 'package:xmshop/app/modules/address/addressList/controllers/address_list_controller.dart';
import 'package:xmshop/app/modules/chectout/controllers/chectout_controller.dart';
import 'package:xmshop/app/services/httpsClient.dart';
import 'package:xmshop/app/services/signServices.dart';
import 'package:xmshop/app/services/userServices.dart';

class AddressAddController extends GetxController {
  //TODO: Implement AddressAddController

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxString area = ''.obs;
  HttpsClient httpsClient = HttpsClient();
  AddressListController listController = Get.find();
  ChectoutController chectoutController = Get.find();
  AddressItemModel addressItemModel = AddressItemModel();
  @override
  void onInit() {
    super.onInit();
    var json = Get.arguments;
    if (json != null) {
      addressItemModel = AddressItemModel.fromJson(json);
    }
    print(json);
    initAddressData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  initAddressData() {
    if (addressItemModel.sId != null) {
      nameController.text = addressItemModel.name!;
      phoneController.text = addressItemModel.phone!;

      List tempList = addressItemModel.address!.split(' ');
      area.value = '${tempList[0]} ${tempList[1]} ${tempList[2]}';
      update();

      tempList.removeRange(0, 3);
      addressController.text = tempList.join();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  doAddAddress() async {
    if (nameController.text.length < 2 || nameController.text.length > 10) {
      Get.snackbar('提示', '姓名长度为2-10个字符');
    } else if (!GetUtils.isPhoneNumber(phoneController.text) ||
        phoneController.text.length != 11) {
      Get.snackbar('提示', '手机号不合法');
    } else if (area.value.length < 2) {
      Get.snackbar('提示', '请选择地区"');
    } else if (addressController.text.length < 2) {
      Get.snackbar('提示', '请填写详细的地址');
    } else {
      List userList = await UserServices.getUserInfo();
      UserModel userInfo = UserModel.fromJson(userList.first);
      String url = '';
      Map tempJson = {};
      if (addressItemModel.sId != null) {
        url = 'api/editAddress';
        tempJson = {
          'id': addressItemModel.sId,
          'name': nameController.text,
          'phone': phoneController.text,
          'uid': userInfo.sId,
          'address': "${area.value} ${addressController.text}",
        };
      } else {
        url = "api/addAddress";
        tempJson = {
          'name': nameController.text,
          'phone': phoneController.text,
          'uid': userInfo.sId,
          'address': "${area.value} ${addressController.text}",
        };
      }
      String sign = SignServices.getSign({...tempJson, 'salt': userInfo.salt});
      var respons =
          await httpsClient.post(url, data: ({...tempJson, 'sign': sign}));
      if (respons.data['success']) {
        listController.getAddressList();
        chectoutController.getDefaultAddress();
        Get.back();
      } else {
        Get.snackbar('提示信息', respons.data['message']);
      }
    }
  }
}
