import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:xmshop/app/models/address_model.dart';
import 'package:xmshop/app/models/user_model.dart';
import 'package:xmshop/app/modules/cart/controllers/cart_controller.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/cartServices.dart';
import 'package:xmshop/app/services/httpsClient.dart';
import 'package:xmshop/app/services/signServices.dart';
import 'package:xmshop/app/services/storage.dart';
import 'package:xmshop/app/services/userServices.dart';

class ChectoutController extends GetxController {
  //TODO: Implement ChectoutController
  CartController cartController = Get.find();
  HttpsClient httpsClient = HttpsClient();
  RxList checkoutList = [].obs;
  RxList<AddressItemModel> addressList = <AddressItemModel>[].obs;

  RxInt allNum = 0.obs;
  RxDouble allPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getCheckoutData();
    getDefaultAddress();
  }

  getCheckoutData() async {
    List tempList = await Storage.getData("checkoutList");
    checkoutList.value = tempList;
    calculatePrice();
    update();
  }

  getDefaultAddress() async {
    List userList = await UserServices.getUserInfo();
    UserModel userinfo = UserModel.fromJson(userList[0]);
    Map tempJosn = {'uid': userinfo.sId};
    String sign = SignServices.getSign({...tempJosn, 'salt': userinfo.salt});
    var response = await httpsClient
        .get('api/oneAddressList?uid=${userinfo.sId}&sign=$sign');
    print(response);
    if (response != null) {
      var tempAddressList = AddressModel.fromJson(response.data);
      addressList.value = tempAddressList.result!;
      update();
    }
  }

  calculatePrice() async {
    int tempNum = 0;
    double tempPrice = 0.0;
    for (var element in checkoutList) {
      tempPrice += (element['price'] as int) * (element['count'] as int);
      tempNum += (element['count'] as int);
    }

    allNum.value = tempNum;
    allPrice.value = tempPrice;
  }

  doCheckOut() async {
    if (addressList.isEmpty) {
      Get.snackbar('提示', '请选择地址');
    } else {
      List userList = await UserServices.getUserInfo();
      UserModel userInfo = UserModel.fromJson(userList[0]);
      Map tempJson = {
        "uid": userInfo.sId,
        "phone": addressList[0].phone,
        "address": addressList[0].address,
        "name": addressList[0].name,
        "all_price": allPrice.value.toStringAsFixed(1), //注意：保留 1 位小数
        "products": json.encode(checkoutList), //需要传入json字符串
      };
      String sign = SignServices.getSign({...tempJson, 'salt': userInfo.salt});

      var response = await httpsClient
          .post('api/doOrder', data: {...tempJson, 'sign': sign});
      print(response);
      if (response.data['success']) {
        Get.toNamed(Routes.PAY);
        await CartServices.deleteChectoutList(checkoutList);
        cartController.getCartListData();
      } else {
        Get.snackbar("提示信息", response.data["message"]);
      }
    }
  }
}
