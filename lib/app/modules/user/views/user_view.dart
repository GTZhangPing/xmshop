import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/screenAdapter.dart';
import 'package:xmshop/app/widget/passButton.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              const Text('会员码'),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.qr_code_outlined)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.message_outlined)),
            ],
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Obx(
        () => ListView(
          controller: controller.scrollController,
          padding: EdgeInsets.all(ScreenAdapter.height(28)),
          children: [
            !controller.isLogin.value
                ? InkWell(
                    onTap: () {
                      Get.toNamed(Routes.CODE_LOGIN_STEP_ONE);
                    },
                    child: Row(
                      children: [
                        Container(
                          height: ScreenAdapter.height(150),
                          width: ScreenAdapter.height(150),
                          margin: EdgeInsets.all(ScreenAdapter.height(40)),
                          child: CircleAvatar(
                            radius: ScreenAdapter.width(75),
                            backgroundImage:
                                const AssetImage("assets/images/user.png"),
                          ),
                        ),
                        Text("登录/注册",
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(46))),
                        SizedBox(width: ScreenAdapter.width(40)),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: ScreenAdapter.fontSize(34),
                          color: Colors.black54,
                        )
                      ],
                    ),
                  )
                : Row(
                    children: [
                      Container(
                        height: ScreenAdapter.height(150),
                        width: ScreenAdapter.height(150),
                        margin: EdgeInsets.all(ScreenAdapter.height(40)),
                        child: CircleAvatar(
                          radius: ScreenAdapter.width(75),
                          backgroundImage:
                              const AssetImage("assets/images/user.png"),
                        ),
                      ),
                      SizedBox(width: ScreenAdapter.width(40)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${controller.userInfo.value.username}",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(46))),
                          SizedBox(height: ScreenAdapter.height(20)),
                          Text("普通会员",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(46)))
                        ],
                      ),
                      SizedBox(width: ScreenAdapter.width(40)),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: ScreenAdapter.fontSize(34),
                        color: Colors.black54,
                      )
                    ],
                  ),
            SizedBox(
              height: ScreenAdapter.height(160),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.isLogin.value
                              ? '${controller.userInfo.value.gold}'
                              : "-",
                          style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(80),
                          ),
                        ),
                        Text("米金",
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(34),
                                color: Colors.black45)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.isLogin.value
                              ? '${controller.userInfo.value.coupon}'
                              : "-",
                          style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(80),
                          ),
                        ),
                        Text("优惠券",
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(34),
                                color: Colors.black45)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.isLogin.value
                              ? '${controller.userInfo.value.redPacket}'
                              : "-",
                          style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(80),
                          ),
                        ),
                        Text("红包",
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(34),
                                color: Colors.black45)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.isLogin.value
                              ? '${controller.userInfo.value.quota}'
                              : "-",
                          style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(80),
                          ),
                        ),
                        Text("最高额度",
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(34),
                                color: Colors.black45)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.bookmarks_outlined),
                        Text("钱包",
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(34),
                                color: Colors.black45)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenAdapter.height(50)),
              width: ScreenAdapter.width(1008),
              height: ScreenAdapter.height(300),
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage("assets/images/user_ad1.png"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(ScreenAdapter.width(20))),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenAdapter.height(50)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenAdapter.width(20)),
              ),
              child: Column(
                children: [
                  Container(
                    height: ScreenAdapter.height(100),
                    margin: EdgeInsets.only(
                        top: ScreenAdapter.height(20),
                        bottom: ScreenAdapter.height(20)),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Center(
                            child: Text("收藏",
                                style: TextStyle(color: Colors.black54)),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color: Colors.black12,
                                    width: ScreenAdapter.width(2)),
                                right: BorderSide(
                                    color: Colors.black12,
                                    width: ScreenAdapter.width(2)),
                              ),
                            ),
                            child: const Text("足迹",
                                style: TextStyle(color: Colors.black54)),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: Center(
                            child: Text("关注",
                                style: TextStyle(color: Colors.black54)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenAdapter.width(40),
                        right: ScreenAdapter.width(40)),
                    child: Divider(
                      height: ScreenAdapter.height(2),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: ScreenAdapter.height(60),
                        bottom: ScreenAdapter.height(40)),
                    height: ScreenAdapter.height(270),
                    child: const Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.bookmarks_outlined,
                                  color: Colors.black87),
                              Text("待付款",
                                  style: TextStyle(color: Colors.black87))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.car_crash, color: Colors.black87),
                              Text("待收货",
                                  style: TextStyle(color: Colors.black87))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.question_answer_outlined,
                                color: Colors.black87,
                              ),
                              Text("待评价",
                                  style: TextStyle(color: Colors.black87))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.design_services_outlined,
                                  color: Colors.black87),
                              Text("退换/售后",
                                  style: TextStyle(color: Colors.black87))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.copy_all_rounded,
                                  color: Colors.black87),
                              Text("全部订单",
                                  style: TextStyle(color: Colors.black87))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenAdapter.height(50)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(ScreenAdapter.height(28)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("服务",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: ScreenAdapter.fontSize(44),
                                fontWeight: FontWeight.bold)),
                        const Text(
                          "更多 > ",
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                  GridView.count(
                    crossAxisCount: 4,
                    childAspectRatio: 1.253,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.copy_all_rounded,
                              color: Colors.orange),
                          SizedBox(
                            height: ScreenAdapter.height(20),
                          ),
                          const Text("一键退换")
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.copy_all_rounded,
                              color: Colors.orange),
                          SizedBox(
                            height: ScreenAdapter.height(20),
                          ),
                          const Text("一键退换")
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.copy_all_rounded,
                              color: Colors.orange),
                          SizedBox(
                            height: ScreenAdapter.height(20),
                          ),
                          const Text("一键退换")
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.copy_all_rounded,
                              color: Colors.orange),
                          SizedBox(
                            height: ScreenAdapter.height(20),
                          ),
                          const Text("一键退换")
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.copy_all_rounded,
                              color: Colors.orange),
                          SizedBox(
                            height: ScreenAdapter.height(20),
                          ),
                          const Text("一键退换")
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.copy_all_rounded,
                              color: Colors.orange),
                          SizedBox(
                            height: ScreenAdapter.height(20),
                          ),
                          const Text("一键退换")
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.copy_all_rounded,
                              color: Colors.orange),
                          SizedBox(
                            height: ScreenAdapter.height(20),
                          ),
                          const Text("一键退换")
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.copy_all_rounded,
                              color: Colors.orange),
                          SizedBox(
                            height: ScreenAdapter.height(20),
                          ),
                          const Text("一键退换")
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //广告
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: ScreenAdapter.height(50)),
              child: Container(
                width: ScreenAdapter.width(1008),
                height: ScreenAdapter.height(300),
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage("assets/images/user_ad2.png"),
                        fit: BoxFit.cover),
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.width(20))),
              ),
            ),
            controller.isLogin.value
                ? PassButton(
                    text: '退出登陆',
                    onPressed: () {
                      controller.loginOut();
                      controller.scrollController.jumpTo(0);
                    },
                  )
                : SizedBox(
                    height: ScreenAdapter.height(1),
                  )
          ],
        ),
      ),
    );
  }
}
