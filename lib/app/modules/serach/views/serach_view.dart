import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/serach_controller.dart';

class SerachView extends GetView<SerachController> {
  const SerachView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SerachView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SerachView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
