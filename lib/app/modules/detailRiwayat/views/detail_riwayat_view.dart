import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';
import '../../../utils/custom_output_detail.dart';
import '../controllers/detail_riwayat_controller.dart';

class DetailRiwayatView extends GetView<DetailRiwayatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Detail'),
        ),
        body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getData(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              // controller.namaC.text = data['kategori'];
              return Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: Stack(
                  children: [
                    /// PEREKAMAN e-KTP
                    if ("${data['kategori']}" == 'Perekaman e-KTP')
                      Positioned(
                        top: 13,
                        child: Container(
                          width: 320.w,
                          height: 440.h,
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
                              width: Get.width * 0.5,
                              height: 440.h,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  width: 1,
                                  color: kGreyColor,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${data['proses']}",
                                          style: blackTextStyle.copyWith(
                                              fontWeight: semiBold),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NIK',
                                        subtitle: "${data['nik']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP',
                                        subtitle: "${data['nama']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'TANGGAL LAHIR',
                                        subtitle: "${data['tgl_lahir']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'KECAMATAN',
                                        subtitle: "${data['kecamatan']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'DESA',
                                        subtitle: "${data['desa']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'STATUS',
                                        subtitle: "${data['proses']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'TANGGAL KONFIRMASI',
                                        subtitle: DateFormat(
                                          "d MMMM yyyy",
                                          "id_ID",
                                        ).format(
                                          DateTime.parse(
                                            "${data['updatedTime']}",
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      if ("${data['keterangan']}".isEmpty)
                                        Container(),
                                      if ("${data['keterangan']}".isNotEmpty)
                                        CustomOutputForm(
                                          title: 'KETERANGAN',
                                          subtitle: "${data['keterangan']}",
                                        ),
                                      if ("${data['keteranganKonfirmasi']}"
                                          .isEmpty)
                                        Container(),
                                      if ("${data['keteranganKonfirmasi']}"
                                          .isNotEmpty)
                                        CustomOutputForm(
                                          title: 'KETERANGAN KONFIRMASI',
                                          subtitle:
                                              "${data['keteranganKonfirmasi']}",
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                            "${data['kategori']}",
                            style: whiteTextStyle,
                          ),
                        ),
                      ),
                    ),

                    /// Akta Kematian
                    if ("${data['kategori']}" == 'Akta Kematian')
                      Positioned(
                        top: 13,
                        child: Container(
                          width: 320.w,
                          height: 550.h,
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              width: 1.w,
                              color: kGreyColor,
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 20.h,
                              left: 20.w,
                              right: 20.w,
                              bottom: 20.h,
                            ),
                            child: Container(
                              width: Get.width * 0.5.w,
                              height: 550.h,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  width: 1,
                                  color: kGreyColor,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${data['proses']}",
                                          style: blackTextStyle.copyWith(
                                              fontWeight: semiBold),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      CustomOutputForm(
                                        title: 'NIK JENAZAH',
                                        subtitle: "${data['nikJenazah']}",
                                      ),
                                      SizedBox(height: 10),
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP JENAZAH',
                                        subtitle:
                                            "${data['namaLengkapJenazah']}",
                                      ),
                                      SizedBox(height: 10),
                                      CustomOutputForm(
                                        title: 'NIK AYAH',
                                        subtitle: "${data['NIKayah']}",
                                      ),
                                      CustomOutputForm(
                                        title: 'NAMA AYAH',
                                        subtitle: "${data['namaAyah']}",
                                      ),
                                      SizedBox(height: 10),
                                      CustomOutputForm(
                                        title: 'NIK IBU',
                                        subtitle: "${data['NIKIbu']}",
                                      ),
                                      CustomOutputForm(
                                        title: 'NAMA Ibu',
                                        subtitle: "${data['NamaIbu']}",
                                      ),
                                      CustomOutputForm(
                                        title: 'JENIS KELAMIN',
                                        subtitle: "${data['jenisKelamin']}",
                                      ),
                                      SizedBox(height: 10),
                                      CustomOutputForm(
                                        title: 'TANGGAL LAHIR JENAZAH',
                                        subtitle: DateFormat(
                                          "d MMMM yyyy",
                                          "id_ID",
                                        ).format(
                                          DateTime.parse(
                                            "${data['tgl_lahir']}",
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      CustomOutputForm(
                                        title: 'TEMPAT LAHIR',
                                        subtitle: "${data['tempatLahir']}",
                                      ),
                                      SizedBox(height: 10),
                                      CustomOutputForm(
                                        title: 'KEWARGANEGARAAN',
                                        subtitle: "${data['kewarganegaraan']}",
                                      ),
                                      SizedBox(height: 10),
                                      CustomOutputForm(
                                        title: 'ANAK KE',
                                        subtitle: "${data['anakKe']}",
                                      ),
                                      SizedBox(height: 10),
                                      CustomOutputForm(
                                        title: 'TEMPAT KEMATIAN',
                                        subtitle: "${data['tempatKematian']}",
                                      ),
                                      SizedBox(height: 10),
                                      CustomOutputForm(
                                        title: 'YANG MENERANGKAN',
                                        subtitle: "${data['menerangkan']}",
                                      ),
                                      SizedBox(height: 10),
                                      CustomOutputForm(
                                        title: 'NAMA PELAPOR',
                                        subtitle: "${data['nama']}",
                                      ),
                                      SizedBox(height: 10),
                                      CustomOutputForm(
                                        title: 'NIK PELAPOR',
                                        subtitle: "${data['nik']}",
                                      ),
                                      SizedBox(height: 10),
                                      CustomOutputForm(
                                        title: 'STATUS',
                                        subtitle: "${data['proses']}",
                                      ),
                                      SizedBox(height: 10),
                                      if ("${data['keterangan']}".isEmpty)
                                        Container(),
                                      if ("${data['keterangan']}".isNotEmpty)
                                        CustomOutputForm(
                                          title: 'KETERANGAN',
                                          subtitle: "${data['keterangan']}",
                                        ),
                                      SizedBox(height: 10),
                                      CustomOutputForm(
                                        title: 'TANGGAL KONFIRMASI',
                                        subtitle: DateFormat(
                                          "d MMMM yyyy",
                                          "id_ID",
                                        ).format(
                                          DateTime.parse(
                                            "${data['updatedTime']}",
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      if ("${data['keteranganKonfirmasi']}"
                                          .isEmpty)
                                        Container(),
                                      if ("${data['keteranganKonfirmasi']}"
                                          .isNotEmpty)
                                        CustomOutputForm(
                                          title: 'KETERANGAN KONFIRMASI',
                                          subtitle:
                                              "${data['keteranganKonfirmasi']}",
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                            "${data['kategori']}",
                            style: whiteTextStyle,
                          ),
                        ),
                      ),
                    ),
                    ///// Perubahan e-Ktp
                    if ("${data['kategori']}" == 'Perubahan e-KTP')
                      Positioned(
                        top: 13,
                        child: Container(
                          width: 320.w,
                          height: 528.h,
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
                              top: 20.h,
                              left: 20.w,
                              right: 20.w,
                              bottom: 20.h,
                            ),
                            child: Container(
                              width: Get.width * 0.5.w,
                              height: 528.h,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  width: 1,
                                  color: kGreyColor,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${data['proses']}",
                                          style: blackTextStyle.copyWith(
                                              fontWeight: semiBold),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NIK',
                                        subtitle: "${data['nik']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP',
                                        subtitle: "${data['nama']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'TANGGAL LAHIR',
                                        subtitle: "${data['tgl_lahir']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'KECAMATAN',
                                        subtitle: "${data['kecamatan']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'DESA',
                                        subtitle: "${data['desa']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'STATUS',
                                        subtitle: "${data['proses']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'TANGGAL KONFIRMASI',
                                        subtitle: DateFormat(
                                          "d MMMM yyyy",
                                          "id_ID",
                                        ).format(
                                          DateTime.parse(
                                            "${data['updatedTime']}",
                                          ),
                                        ),
                                      ),
                                      if ("${data['keterangan']}".isEmpty)
                                        Container(),
                                      if ("${data['keterangan']}".isNotEmpty)
                                        CustomOutputForm(
                                          title: 'KETERANGAN',
                                          subtitle: "${data['keterangan']}",
                                        ),
                                      if ("${data['keteranganKonfirmasi']}"
                                          .isEmpty)
                                        Container(),
                                      if ("${data['keteranganKonfirmasi']}"
                                          .isNotEmpty)
                                        CustomOutputForm(
                                          title: 'KETERANGAN KONFIRMASI',
                                          subtitle:
                                              "${data['keteranganKonfirmasi']}",
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                            "${data['kategori']}",
                            style: whiteTextStyle,
                          ),
                        ),
                      ),
                    ),

                    ///AKTA PERKAWINAN

                    if ("${data['kategori']}" == 'Akta Nikah')
                      Positioned(
                        top: 13,
                        child: Container(
                          width: 320.w,
                          height: 530.h,
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
                              width: Get.width * 0.5,
                              height: 530.h,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  width: 1,
                                  color: kGreyColor,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${data['proses']}",
                                          style: blackTextStyle.copyWith(
                                              fontWeight: semiBold),
                                        ),
                                      ),

                                      ///SUAMI
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NIK SUAMI',
                                        subtitle: "${data['nikSuami']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP SUAMI',
                                        subtitle: "${data['namaLengkapSuami']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'TANGGAL LAHIR SUAMI',
                                        subtitle:
                                            "${data['tanggalLahirSuami']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'TEMPAT LAHIR SUAMI',
                                        subtitle: "${data['tempatLahirSuami']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'KEWARGANEGARAAN SUAMI',
                                        subtitle:
                                            "${data['kewarganegaraanSuami']}",
                                      ),
                                      SizedBox(height: 10.h),

                                      ///ISTRI
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NIK ISTRI',
                                        subtitle: "${data['nikIstri']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP ISTRI',
                                        subtitle: "${data['namaLengkapIstri']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'TANGGAL LAHIR ISTRI',
                                        subtitle:
                                            "${data['tanggalLahirIstri']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'TEMPAT LAHIR ISTRI',
                                        subtitle: "${data['tempatLahirIstri']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'KEWARGANEGARAAN ISTRI',
                                        subtitle:
                                            "${data['kewarganegaraanIstri']}",
                                      ),
                                      SizedBox(height: 10.h),

                                      ///SAKSI 1 & 2
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NIK SAKSI 1',
                                        subtitle: "${data['nikSuami']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP SUAMI',
                                        subtitle: "${data['namaLengkapSuami']}",
                                      ),
                                      SizedBox(height: 10.h),

                                      ///PROSES
                                      CustomOutputForm(
                                        title: 'STATUS',
                                        subtitle: "${data['proses']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'TANGGAL KONFIRMASI',
                                        subtitle: DateFormat(
                                          "d MMMM yyyy",
                                          "id_ID",
                                        ).format(
                                          DateTime.parse(
                                            "${data['updatedTime']}",
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      if ("${data['keterangan']}".isEmpty)
                                        Container(),
                                      if ("${data['keterangan']}".isNotEmpty)
                                        CustomOutputForm(
                                          title: 'KETERANGAN',
                                          subtitle: "${data['keterangan']}",
                                        ),
                                      if ("${data['keteranganKonfirmasi']}"
                                          .isEmpty)
                                        Container(),
                                      if ("${data['keteranganKonfirmasi']}"
                                          .isNotEmpty)
                                        CustomOutputForm(
                                          title: 'KETERANGAN KONFIRMASI',
                                          subtitle:
                                              "${data['keteranganKonfirmasi']}",
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                            "${data['kategori']}",
                            style: whiteTextStyle,
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
