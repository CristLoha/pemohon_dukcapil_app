import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rekamanan_ktp_controller.dart';

class RekamananKtpView extends GetView<RekamananKtpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RekamananKtpView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RekamananKtpView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
