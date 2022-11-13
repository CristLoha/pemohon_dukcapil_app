import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pemohon_dukcapil_app/app/routes/app_pages.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat'),
        backgroundColor: kPrimaryColor,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamKTP(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty || snapshot.data == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: Column(
                    children: [
                      LottieBuilder.asset('assets/lottie/empty_box.json'),
                      Text('Belum ada data',
                          style: blackTextStyle.copyWith(fontSize: 16.h))
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                var docRiwayat = snapshot.data!.docs[index];
                Map<String, dynamic> ktp = docRiwayat.data();
                return Column(
                  children: [
                    ListTile(
                      onTap: () => Get.toNamed(
                        Routes.DETAIL_RIWAYAT,
                        arguments: docRiwayat.id,
                      ),
                      title: Text(
                        "${ktp['kategori']}",
                        style: blackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 13.h,
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 5),
                          if ("${ktp['proses']}" == 'PROSES VERIFIKASI')
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5,
                              ),
                              child: Container(
                                width: 102,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xffff7f50),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "PROSES VERIFIKASI",
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 9, fontWeight: semiBold),
                                  ),
                                ),
                              ),
                            )
                          else if ("${ktp['proses']}" == 'PENDING')
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                width: 102,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "PENDING",
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 9, fontWeight: semiBold),
                                  ),
                                ),
                              ),
                            )
                          else if ("${ktp['proses']}" == 'DICETAK')
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                width: 102,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 211, 90, 156),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "PROSES PENCETAKAN",
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 9, fontWeight: semiBold),
                                  ),
                                ),
                              ),
                            )
                          else if ("${ktp['proses']}" == 'AMBIL')
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                width: 102,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "SIAP AMBIL",
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 9, fontWeight: semiBold),
                                  ),
                                ),
                              ),
                            ),
                          if ("${ktp['proses']}" == 'DITOLAK')
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                              ),
                              child: Container(
                                width: 102,
                                height: 30,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: kRedColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "DITOLAK",
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 9, fontWeight: semiBold),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat(
                              "d MMMM yyyy",
                              "id_ID",
                            ).format(
                              DateTime.parse(
                                "${ktp['updatedTime']}",
                              ),
                            ),
                            style: greyTextStyle.copyWith(fontSize: 10.h),
                          ),
                          Text(
                            DateFormat(
                              "hh:mm aaa",
                              "id_ID",
                            ).format(
                              DateTime.parse(
                                "${ktp['updatedTime']}",
                              ),
                            ),
                            style: greyTextStyle.copyWith(fontSize: 8.h),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 0.80, color: kGreyColor),
                  ],
                );
              }),
            );
          }),
    );
  }
}
