import 'dart:convert';

import 'package:crypto/crypto.dart';

class SignServices {
  // 获取sign
  static String getSign(Map params) {
    List keyList = params.keys.toList();
    keyList.sort();
    String str = '';
    for (var i = 0; i < keyList.length; i++) {
      str = '${str + keyList[i]}${params[keyList[i]]}';
    }
    var sign = md5.convert(utf8.encode(str));
    return '$sign';
  }
}
