import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/akta_perceraian_controller.dart';

class AktaPerceraianView extends GetView<AktaPerceraianController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akta Perceraian'),
      ),
      body: Center(
        child: Text(
          'AktaPerceraianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}