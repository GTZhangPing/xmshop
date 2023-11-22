import 'package:get/get.dart';
import 'package:xmshop/app/models/order_model.dart';
import 'package:xmshop/app/models/user_model.dart';
import 'package:xmshop/app/services/httpsClient.dart';
import 'package:xmshop/app/services/signServices.dart';
import 'package:xmshop/app/services/userServices.dart';

class OrderDetailController extends GetxController {
  //TODO: Implement OrderDetailController

  var orderId = Get.arguments['id'];
  HttpsClient httpsClient = HttpsClient();
  RxList<OrderInfoModel> orderList = <OrderInfoModel>[].obs;

  @override
  void onInit() {
    // getOrderList();
    getOrderInfo();
    super.onInit();
  }

  getOrderInfo() async {
    List userList = await UserServices.getUserInfo();
    UserModel useModel = UserModel.fromJson(userList[0]);
    String sign = SignServices.getSign(
        {"uid": useModel.sId, "id": orderId, "salt": useModel.salt});
    var response = await httpsClient
        .get("/api/orderInfo?uid=${useModel.sId}&id=$orderId&sign=$sign");
    print(response.data);
    if (response != null) {
      OrderModel orderModel = OrderModel.fromJson(response.data);
      orderList.value = orderModel.result!;
      update();
    }
  }
}
