import 'package:get/get.dart';

import '../controllers/chectout_controller.dart';

class ChectoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChectoutController>(
      () => ChectoutController(),
    );
  }
}
