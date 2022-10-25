import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

            return ListView.builder(
              padding: EdgeInsets.only(
                left: 5,
                right: 10,
                bottom: 75,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                var docKTP = snapshot.data!.docs[index];
                Map<String, dynamic> ktp = docKTP.data();
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Perekaman e-KTP',
                        style: blackTextStyle.copyWith(
                          fontWeight: semiBold,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        "${ktp['nama']}",
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        'Status',
                        style: greyTextStyle.copyWith(fontSize: 10),
                      ),
                      SizedBox(width: 5),
                      if ("${ktp['proses']}" == 'PROSES VERIFIKASI')
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "PROSES VERIFIKASI",
                            style: whiteTextStyle.copyWith(fontSize: 9),
                          ),
                        )
                      else if ("${ktp['proses']}" == 'SIAP AMBIL')
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "SIAP AMBIL",
                            style: whiteTextStyle.copyWith(fontSize: 9),
                          ),
                        ),
                      if ("${ktp['proses']}" == 'DITOLAK')
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "DITOLAK",
                            style: whiteTextStyle.copyWith(fontSize: 9),
                          ),
                        ),
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2022-11-05',
                        style: blackTextStyle.copyWith(fontSize: 12),
                      ),
                      Text(
                        '12:05',
                        style: blackTextStyle.copyWith(fontSize: 10),
                      ),
                    ],
                  ),
                  leading: Icon(
                    Icons.card_giftcard,
                  ),
                );
              }),
            );
          }),
    );
  }
}
