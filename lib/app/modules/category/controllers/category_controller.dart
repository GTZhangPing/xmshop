import 'package:get/get.dart';

import '../../../models/category_model.dart';
import '../../../services/httpsClient.dart';

class CategoryController extends GetxController {
  //TODO: Implement CategoryController
  HttpsClient httpsClient = HttpsClient();

  final selecetIndex = 0.obs;
  RxList leftList = [].obs;
  RxList rightList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getLeftList();
  }

  changeIndex(index) {
    selecetIndex.value = index;
    getRightList(leftList[selecetIndex.value].sId);
    update();
  }

  getLeftList() async {
    var response = await httpsClient.get("api/pcate");
    var list = CategoryModel.fromJson(response.data).result;
    leftList.value = list!;
    getRightList(leftList[0].sId);
    update();
  }

  getRightList(pid) async {
    var response =
        await httpsClient.get("api/pcate?pid=$pid");
    var list = CategoryModel.fromJson(response.data).result;
    rightList.value = list!;
    update();
  }
}
