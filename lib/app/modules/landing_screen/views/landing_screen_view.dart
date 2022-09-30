import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/landing_screen_controller.dart';

class LandingScreenView extends GetView<LandingScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LandingScreenView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LandingScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
