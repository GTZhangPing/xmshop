import 'package:get/get.dart';
import 'package:xmshop/app/models/address_model.dart';
import 'package:xmshop/app/models/user_model.dart';
import 'package:xmshop/app/modules/chectout/controllers/chectout_controller.dart';
import 'package:xmshop/app/services/httpsClient.dart';
import 'package:xmshop/app/services/signServices.dart';
import 'package:xmshop/app/services/userServices.dart';

class AddressListController extends GetxController {
  //TODO: Implement AddressListController

  HttpsClient httpsClient = HttpsClient();
  RxList<AddressItemModel> addressList = <AddressItemModel>[].obs;
  ChectoutController chectoutController = Get.find();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getAddressList();
  }

  getAddressList() async {
    List userList = await UserServices.getUserInfo();
    UserModel userInfo = UserModel.fromJson(userList.first);
    Map tempJson = {'uid': userInfo.sId};
    String sign = SignServices.getSign({...tempJson, 'salt': userInfo.salt});

    var result =
        await httpsClient.get("api/addressList?uid=${userInfo.sId}&sign=$sign");
    print(result);
    if (result != null) {
      var tempresult = AddressModel.fromJson(result.data);
      addressList.value = tempresult.result!;
      update();
    }
  }

  changeDefalutAddress(id) async {
    List userList = await UserServices.getUserInfo();
    UserModel userInfo = UserModel.fromJson(userList[0]);

    Map tempJson = {'uid': userInfo.sId, 'id': id};
    String sign = SignServices.getSign({...tempJson, 'salt': userInfo.salt});

    var response = await httpsClient
        .post('api/changeDefaultAddress', data: {...tempJson, 'sign': sign});
    print(response);
    if (response != null) {
      Get.back();
      chectoutController.getDefaultAddress();
    }
  }

  deleteAddress(id) async {
    List userList = await UserServices.getUserInfo();
    UserModel userInfo = UserModel.fromJson(userList[0]);

    Map tempJson = {'uid': userInfo.sId, 'id': id};
    String sign = SignServices.getSign({...tempJson, 'salt': userInfo.salt});
    var response = await httpsClient
        .post('api/deleteAddress', data: {...tempJson, 'sign': sign});
    print(response);
    if (response != null) {
      getAddressList();
    }
  }
}
