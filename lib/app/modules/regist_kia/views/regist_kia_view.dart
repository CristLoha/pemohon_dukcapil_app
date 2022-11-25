import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/regist_kia_controller.dart';

class RegistKiaView extends GetView<RegistKiaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegistKiaView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RegistKiaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
