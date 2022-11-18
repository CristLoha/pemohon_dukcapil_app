import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/regis_akta_kematian_controller.dart';

class RegisAktaKematianView extends GetView<RegisAktaKematianController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RegisAktaKematianView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RegisAktaKematianView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
