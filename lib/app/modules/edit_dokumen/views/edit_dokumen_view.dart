import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

import '../../../utils/custom_form_input.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/edit_dokumen_controller.dart';

class EditDokumenView extends GetView<EditDokumenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FutureBuilder(
            future: controller.getData(Get.arguments),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data!.data() as Map<String, dynamic>;

                return Text('Edit ${data['kategori']}');
              }
              return CircularProgressIndicator();
            },
          ),
          backgroundColor: kPrimaryColor,
        ),
        body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getData(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              if (data["kategori"] == "Akta Kelahiran") {
                controller.kabupatenC.text = data["kabupatenPemohon"];
                // tampilkan form untuk Akta Kelahiran
              } else {
                if (data["kategori"] == "Perekaman e-KTP") {
                  controller.kabupatenPerC.text = data["kabupaten"];
                  // tampilkan form untuk Perekaman e-KTP
                }
              }
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  if ("${data['kategori']}" == 'Akta Kelahiran')
                    Column(
                      children: [
                        CustomTitleWidget(title: 'kabupaten Pemohon'),
                        SizedBox(height: 12.h),
                        CustomFormField(
                          readOnly: true,
                          textEditingController: controller.kabupatenC,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                        ),
                      ],
                    ),

                  ///perekaman eKTP
                  if ("${data['kategori']}" == 'Perekaman e-KTP')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTitleWidget(title: 'Perekaman'),
                        SizedBox(height: 12.h),
                        CustomFormField(
                          readOnly: true,
                          textEditingController: controller.kabupatenPerC,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                        ),
                      ],
                    ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: kPrimaryColor,
              ),
            );
          },
        ));
  }
}
