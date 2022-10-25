import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/modules/login/views/login_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/main_page/views/main_page_view.dart';

import '../../../data/models/pemohon_model.dart';
import '../../../shared/theme.dart';
import '../../register/controllers/register_controller.dart';
import '../controllers/landing_screen_controller.dart';

class LandingScreenView extends GetView<LandingScreenController> {
  final register = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
          stream: controller.collectionPemohon
              .doc(controller.userPemohon!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Terjadi Kesahalahan'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var data = snapshot.data?.data();

            if (data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.data!.exists) {
              return LoginView();
            }
            Pemohon pemohon = Pemohon.fromJson(data as Map<String, dynamic>);
            if (pemohon.validasi == true) {
              return MainPageView();
            }

            return ListView(
              padding: EdgeInsets.symmetric(vertical: 300, horizontal: 30),
              children: [
                Center(
                  child: Text('Menunggu validasi dari Staff Pelayanan'),
                ),
                SizedBox(height: 20),
                Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      controller.signOut();
                    },
                    child: Text(
                      controller.isLoading.isFalse ? 'Keluar' : 'Memuat...',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16.sp,
                        fontWeight: medium,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
