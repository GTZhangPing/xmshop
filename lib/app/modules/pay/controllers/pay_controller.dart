import 'package:get/get.dart';

class PayController extends GetxController {
  //TODO: Implement PayController
  RxList payList = [
    {
      "id": 1,
      "title": "支付宝支付",
      "chekced": true,
      "image": "https://www.itying.com/themes/itying/images/alipay.png"
    },
    {
      "id": 2,
      "title": "微信支付",
      "chekced": false,
      "image": "https://www.itying.com/themes/itying/images/weixinpay.png"
    }
  ].obs;

  String payType = '支付宝支付';

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  changePayList(String payType) {
    List<Map<String, Object>> tempList = [];
    for (var i = 0; i < payList.length; i++) {
      if (payList[i]['title'] == payType) {
        payList[i]['chekced'] = true;
        payType = payList[i]['title'];
      } else {
        payList[i]['chekced'] = false;
      }
      tempList.add(payList[i]);
    }
    print(payType);

    payList.value = tempList;
    update();
  }
}
