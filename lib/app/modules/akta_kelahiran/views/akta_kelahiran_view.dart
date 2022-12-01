import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/akta_kelahiran_controller.dart';

class AktaKelahiranView extends GetView<AktaKelahiranController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AktaKelahiranView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AktaKelahiranView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
