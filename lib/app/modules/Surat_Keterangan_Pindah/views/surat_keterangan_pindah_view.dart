import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/surat_keterangan_pindah_controller.dart';

class SuratKeteranganPindahView
    extends GetView<SuratKeteranganPindahController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SuratKeteranganPindahView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SuratKeteranganPindahView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
