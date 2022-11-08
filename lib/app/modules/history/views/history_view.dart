import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                var docKTP = snapshot.data!.docs[index];
                Map<String, dynamic> ktp = docKTP.data();
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        print('satu dua $index');
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${ktp['kategori']}",
                            style: blackTextStyle.copyWith(
                              fontWeight: semiBold,
                              fontSize: 13.h,
                            ),
                          ),
                          Text(
                            "${ktp['nama']}",
                            style: blackTextStyle.copyWith(
                              fontWeight: medium,
                              fontSize: 13.h,
                            ),
                          ),
                        ],
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
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "PROSES VERIFIKASI",
                                  style: whiteTextStyle.copyWith(
                                      fontSize: 10, fontWeight: semiBold),
                                ),
                              ),
                            )
                          else if ("${ktp['proses']}" == 'SIAP AMBIL')
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 3,
                                top: 3,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "SIAP AMBIL",
                                  style: whiteTextStyle.copyWith(
                                      fontSize: 10, fontWeight: semiBold),
                                ),
                              ),
                            ),
                          if ("${ktp['proses']}" == 'DITOLAK')
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 3,
                                top: 3,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "DITOLAK",
                                  style: whiteTextStyle.copyWith(
                                      fontSize: 10, fontWeight: semiBold),
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
                    Container(height: 1, color: kGreyColor),
                  ],
                );
              }),
            );
          }),
    );
  }
}
