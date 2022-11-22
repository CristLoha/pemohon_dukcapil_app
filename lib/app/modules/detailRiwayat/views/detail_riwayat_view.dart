import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';

import '../controllers/detail_riwayat_controller.dart';

class DetailRiwayatView extends GetView<DetailRiwayatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('DetailRiwayatView'),
          centerTitle: true,
        ),
        body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getData(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              controller.namaC.text = data['kategori'];
              return Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 13,
                      child: Container(
                        width: Get.width * 0.9,
                        height: 420,
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: kGreyColor,
                          ),
                        ),
                        child: Container(
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20,
                              bottom: 20,
                            ),
                            child: Container(
                                width: Get.width * 0.7,
                                height: 420,
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    width: 1,
                                    color: kGreyColor,
                                  ),
                                ))),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      child: Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: kGreyColor,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            'Perekaman E-KTP',
                            style: whiteTextStyle.copyWith(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
