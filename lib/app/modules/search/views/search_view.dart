import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/screenAdapter.dart';
import 'package:xmshop/app/services/searchServices.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchsController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          // color: Colors.red,
          height: ScreenAdapter.height(90),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            autofocus: true,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none)),
            onChanged: (value) {
              controller.keywords = value;
            },
            onSubmitted: (value) {
              SearchServices.setHistoryData(controller.keywords);
              Get.offAndToNamed(Routes.PRODUCT_LIST,
                  arguments: {'keywords': value});
            },
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                SearchServices.setHistoryData(controller.keywords);
                Get.offAndToNamed(Routes.PRODUCT_LIST,
                    arguments: {'keywords': controller.keywords});
              },
              child: Text(
                '搜索',
                style: TextStyle(
                    fontSize: ScreenAdapter.fontSize(50),
                    color: Colors.black87),
              ))
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(30)),
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: ScreenAdapter.height(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('搜索历史',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenAdapter.fontSize(42))),
                IconButton(
                    onPressed: () {
                      controller.clearHistoryData();
                    },
                    icon: const Icon(Icons.delete_forever_outlined)),
              ],
            ),
          ),
          Obx(
            () => Wrap(
                children: controller.historyList
                    .map(
                      (value) => InkWell(
                        child: Container(
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdapter.width(32),
                            ScreenAdapter.width(16),
                            ScreenAdapter.width(32),
                            ScreenAdapter.width(16)),
                        margin: EdgeInsets.all(ScreenAdapter.height(16)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(value),
                      ),
                      onTap: () {
                        SearchServices.setHistoryData(value);
                Get.offAndToNamed(Routes.PRODUCT_LIST,
                    arguments: {'keywords':value});
                      },
                      onLongPress: () {
                        Get.defaultDialog(title: "提示信息!",
                              middleText: "您确定要删除吗?",
                              confirm: ElevatedButton(
                                  onPressed: () {
                                    print("确定");
                                    controller.removeHistoryData(value);
                                    Get.back();
                                  },
                                  child: const Text("确定")),
                                  cancel:  ElevatedButton(
                                  onPressed: () {      
                                    Get.back();
                                  },
                                  child: const Text("取消")));
                      },
                      ),
                    )
                    .toList(),
                // [

                // ],
              ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                0, ScreenAdapter.height(60), 0, ScreenAdapter.height(30)),
            // EdgeInsets.only(bottom: ScreenAdapter.height(40)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('猜你喜欢',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenAdapter.fontSize(42))),
                const Icon(Icons.refresh),
              ],
            ),
          ),
          Wrap(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('手机'),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('手机'),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('手机'),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('手机'),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('手机'),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('手机'),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('手机'),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('手机'),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16),
                    ScreenAdapter.width(32),
                    ScreenAdapter.width(16)),
                margin: EdgeInsets.all(ScreenAdapter.height(16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('手机'),
              ),
            ],
          ),
          SizedBox(height: ScreenAdapter.height(60)),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: ScreenAdapter.height(138),
                  child: Image.asset(
                    "assets/images/hot_search.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(20)),
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: ScreenAdapter.height(20),
                      crossAxisSpacing: ScreenAdapter.width(40),
                      childAspectRatio: 3 / 1,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            width: ScreenAdapter.width(120),
                            child: Image.network(
                              "https://www.itying.com/images/shouji.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.all(ScreenAdapter.width(10)),
                            alignment: Alignment.topLeft,
                            child: const Text("小米净化器 热水器 小米净化器"),
                          ))
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
