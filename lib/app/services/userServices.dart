import "./storage.dart";

class UserServices {
  // 获取用户信息
  static Future<List> getUserInfo() async {
    List userInfo = await Storage.getData('userinfo');
    if (userInfo.isNotEmpty) {
      return userInfo;
    } else {
      return [];
    }
  }

// 获取登陆状态
  static Future<bool> getUserLoginState() async {
    List userInfo = await getUserInfo();
    if (userInfo.isNotEmpty && userInfo[0]['username'] != '') {
      return true;
    }
    return false;
  }

// 退出登陆
  static loginOut() async {
    Storage.deleteData("userinfo");
  }
}
