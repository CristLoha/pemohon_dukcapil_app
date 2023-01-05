import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/routes/app_pages.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Pengaturan'),
        actions: [
          IconButton(
            onPressed: () => controller.logout(),
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Card(
            elevation: 1,
            child: ListTile(
              onTap: (() {
                Get.toNamed(Routes.PROFILE);
              }),
              leading: Icon(
                Icons.person,
                size: 24,
              ),
              title: Text('Profile'),
              subtitle: Text('Ubah kata sandi, ganti nama lengkap'),
            ),
          ),
        ],
      ),
    );
  }
}
