import 'package:get/get.dart';
import 'package:xmshop/app/models/order_model.dart';
import 'package:xmshop/app/models/user_model.dart';
import 'package:xmshop/app/services/httpsClient.dart';
import 'package:xmshop/app/services/signServices.dart';
import 'package:xmshop/app/services/userServices.dart';

class OrderListController extends GetxController {
  //TODO: Implement OrderListController

  RxList<OrderInfoModel> orderList = <OrderInfoModel>[].obs;
  HttpsClient httpsClient = HttpsClient();

  @override
  void onInit() {
    getOrderList();
    super.onInit();
  }

  getOrderList() async {
    List userList = await UserServices.getUserInfo();
    UserModel userModel = UserModel.fromJson(userList[0]);
    String sign =
        SignServices.getSign({'uid': userModel.sId, 'salt': userModel.salt});

    var resopnse =
        await httpsClient.get("/api/orderList?uid=${userModel.sId}&sign=$sign");
    print(resopnse);
    if (resopnse.data != null) {
      OrderModel orderModel = OrderModel.fromJson(resopnse.data);
      orderList.value = orderModel.result!;
      update();
    }
  }
}
