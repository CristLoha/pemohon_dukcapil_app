import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/kartu_keluarga_controller.dart';

class KartuKeluargaView extends GetView<KartuKeluargaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KartuKeluargaView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'KartuKeluargaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
