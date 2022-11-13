import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_riwayat_controller.dart';

class DetailRiwayatView extends GetView<DetailRiwayatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailRiwayatView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailRiwayatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
