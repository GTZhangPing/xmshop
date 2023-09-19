import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/models/user_model.dart';
import 'package:xmshop/app/services/userServices.dart';

class UserController extends GetxController {
  //TODO: Implement UserController

  RxBool isLogin = false.obs;
  var userInfo = UserModel().obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 获取用户信息
  getUserInfo() async {
    var tempLoginState = await UserServices.getUserLoginState();
    isLogin.value = tempLoginState;

    var userList = await UserServices.getUserInfo();
    if (userList.isNotEmpty) {
      userInfo.value = UserModel.fromJson(userList[0]);
    }
  }

//退出登陆
  loginOut() {
    UserServices.loginOut();
    isLogin.value = false;
    userInfo.value = UserModel();
    update();
  }
}
