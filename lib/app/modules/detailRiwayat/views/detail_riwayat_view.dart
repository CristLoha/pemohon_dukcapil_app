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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                          Text(
                                            DateFormat(
                                              "hh:mm aaa",
                                              "id_ID",
                                            ).format(
                                              DateTime.parse(
                                                  "${data['updatedTime']}"),
                                            ),
                                            style: greyTextStyle.copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
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

                                      ///NIK JENAZAH
                                      CustomOutputForm(
                                        title: 'NIK JENAZAH',
                                        subtitle: "${data['nikJenazah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///NAMA LENGKAP JENAZAH
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP JENAZAH',
                                        subtitle:
                                            "${data['namaLengkapJenazah']}",
                                      ),
                                      SizedBox(height: 10),

                                      /// JENIS KELAMIN JENAZAH
                                      CustomOutputForm(
                                        title: 'JENIS KELAMIN JENAZAH',
                                        subtitle:
                                            "${data['jenisKelaminJenazah']}",
                                      ),
                                      SizedBox(height: 10),

                                      /// TANGGAL LAHIR JENAZAH
                                      CustomOutputForm(
                                        title: 'TANGGAL LAHIR JENAZAH',
                                        subtitle: "${data['tgl_lahirJenasah']}",
                                      ),
                                      SizedBox(height: 10),

                                      /// TEMPAT LAHIR
                                      CustomOutputForm(
                                        title: 'TEMPAT LAHIR JENAZAH',
                                        subtitle:
                                            "${data['tempatLahirJenazah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///Agama
                                      CustomOutputForm(
                                        title: 'AGAMA JENAZAH',
                                        subtitle: "${data['agamaJenazah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///Alamat Jenazah
                                      CustomOutputForm(
                                        title: 'ALAMAT JENAZAH',
                                        subtitle: "${data['alamatJenazah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///DESA JENAZAH
                                      CustomOutputForm(
                                        title: 'DESA/KELURAHAN JENAZAH',
                                        subtitle: "${data['desaJenazah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///KECAMATAN JENAZAH
                                      CustomOutputForm(
                                        title: 'KECAMATAN JENAZAH',
                                        subtitle: "${data['kecamatanJenazah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///KABUPATEN/KOTA JENAZAH
                                      CustomOutputForm(
                                        title: 'KABUPATEN/KOTA JENAZAH',
                                        subtitle: "${data['kabupatenJenazah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///PROVINSI JENAZAH
                                      CustomOutputForm(
                                        title: 'PROVINSI',
                                        subtitle: "${data['provinsiJenazah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///ANAK KE
                                      CustomOutputForm(
                                        title: 'ANAK KE',
                                        subtitle: "${data['anakKe']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///TANGGAL KEMATIAN
                                      CustomOutputForm(
                                        title: 'TANGGAL KEMATIAN',
                                        subtitle: "${data['tglKematian']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///PUKUL
                                      CustomOutputForm(
                                        title: 'PUKUL',
                                        subtitle: "${data['pukul']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///TEMPAT KEMATIAN
                                      CustomOutputForm(
                                        title: 'TEMPAT KEMATIAN',
                                        subtitle: "${data['tempatKematian']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///YANG MENERANGKAN
                                      CustomOutputForm(
                                        title: 'YANG MENERANGKAN',
                                        subtitle: "${data['yangMenerangkan']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///Sebab kematian
                                      CustomOutputForm(
                                        title: 'SEBAB KEMATIAN',
                                        subtitle: "${data['sebabKematian']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///------------------------AYAH--------
                                      ///AYAH
                                      CustomOutputForm(
                                        title: 'NIK AYAH',
                                        subtitle: "${data['nikAyah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///NO KK
                                      CustomOutputForm(
                                        title: 'NOMOR KK',
                                        subtitle: "${data['noKK']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///NAMA LENGKAP AYAH
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP AYAH',
                                        subtitle: "${data['namaAyah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///TANGGAL LAHIR AYAH
                                      CustomOutputForm(
                                        title: 'TANGGAL LAHIR AYAH',
                                        subtitle: "${data['tglLahirAyah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///PEKERJAAN AYAH
                                      CustomOutputForm(
                                        title: 'PEKERJAAN AYAH',
                                        subtitle: "${data['pekerjaanAyah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///ALAMAT AYAH
                                      CustomOutputForm(
                                        title: 'ALAMAT AYAH',
                                        subtitle: "${data['alamatAyah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///DESA AYAH
                                      CustomOutputForm(
                                        title: 'DESA/KELURAHAN AYAH',
                                        subtitle: "${data['desaAyah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///KECAMATAN AYAH
                                      CustomOutputForm(
                                        title: 'KECAMATAN AYAH',
                                        subtitle: "${data['kecamatanAyah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///KABUPATEN/KOTA AYAH
                                      CustomOutputForm(
                                        title: 'KECAMATAN AYAH',
                                        subtitle: "${data['kabupatenAyah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///PROVINSI AYAH
                                      CustomOutputForm(
                                        title: 'PROVINSI AYAH',
                                        subtitle: "${data['provinsiAyah']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///------------------------IBU--------
                                      ///NIK IBU
                                      CustomOutputForm(
                                        title: 'NIK IBU',
                                        subtitle: "${data['nikIbu']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///NAMA LENGKAP AYAH
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP IBU',
                                        subtitle: "${data['namaIbu']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///TANGGAL LAHIR AYAH
                                      CustomOutputForm(
                                        title: 'TANGGAL LAHIR IBU',
                                        subtitle: "${data['tglLahirIbu']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///PEKERJAAN IBU
                                      CustomOutputForm(
                                        title: 'PEKERJAAN IBU',
                                        subtitle: "${data['pekerjaanIbu']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///ALAMAT IBU
                                      CustomOutputForm(
                                        title: 'ALAMAT IBU',
                                        subtitle: "${data['alamatIbu']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///DESA IBU
                                      CustomOutputForm(
                                        title: 'DESA/KELURAHAN IBU',
                                        subtitle: "${data['desaIbu']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///KECAMATAN IBU
                                      CustomOutputForm(
                                        title: 'KECAMATAN IBU',
                                        subtitle: "${data['kecamatanIbu']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///KABUPATEN/KOTA IBU
                                      CustomOutputForm(
                                        title: 'KABUPATEN/KOTA IBU',
                                        subtitle: "${data['kecamatanIbu']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///PROVINSI IBU
                                      CustomOutputForm(
                                        title: 'PROVINSI IBU',
                                        subtitle: "${data['provinsiIbu']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///------------------------PEMOHON--------
                                      ///NIK PEMOHON
                                      CustomOutputForm(
                                        title: 'NIK PEMOHON',
                                        subtitle: "${data['nikPemohon']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///NAMA LENGKAP PEMOHON
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP PEMOHON',
                                        subtitle:
                                            "${data['namaLengkapPemohon']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///TANGGAL LAHIR PEMOHON
                                      CustomOutputForm(
                                        title: 'TANGGAL LAHIR PEMOHON',
                                        subtitle:
                                            "${data['tanggalLahirPemohon']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///PEKERJAAN PEMOHON
                                      CustomOutputForm(
                                        title: 'PEKERJAAN PEMOHON',
                                        subtitle: "${data['pekerjaanPemohon']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///ALAMAT PEMOHON
                                      CustomOutputForm(
                                        title: 'ALAMAT PEMOHON',
                                        subtitle: "${data['alamatPemohon']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///DESA PEMOHON
                                      CustomOutputForm(
                                        title: 'DESA/KELURAHAN PEMOHON',
                                        subtitle: "${data['desaPemohon']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///KECAMATAN PEMOHON
                                      CustomOutputForm(
                                        title: 'KECAMATAN PEMOHON',
                                        subtitle: "${data['kecamatanPemohon']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///KABUPATEN/KOTA PEMOHON
                                      CustomOutputForm(
                                        title: 'KABUPATEN/KOTA PEMOHON',
                                        subtitle: "${data['kecamatanPemohon']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///PROVINSI PEMOHON
                                      CustomOutputForm(
                                        title: 'PROVINSI PEMOHON',
                                        subtitle: "${data['provinsiPemohon']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///EMAIL PEMOHON
                                      CustomOutputForm(
                                        title: 'EMAIL PEMOHON',
                                        subtitle: "${data['email']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///NOMOR TELEPON PEMOHON
                                      CustomOutputForm(
                                        title: 'NOMOR TELEPON PEMOHON',
                                        subtitle: "${data['noTelpon']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///------------------------SAKSI 1--------
                                      ///NIK SAKSI 1
                                      CustomOutputForm(
                                        title: 'NIK SAKSI 1 (SATU)',
                                        subtitle: "${data['nikSaksi1']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///NAMA LENGKAP SAKSI 1
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP 1 (SATU)',
                                        subtitle:
                                            "${data['namaLengkapSaksi1']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///TANGGAL LAHIR SAKSI 1
                                      CustomOutputForm(
                                        title: 'TANGGAL LAHIR 1 (SATU)',
                                        subtitle:
                                            "${data['tanggalLahirSaksi1']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///PEKERJAAN SAKSI 1
                                      CustomOutputForm(
                                        title: 'PEKERJAANR1 (SATU)',
                                        subtitle: "${data['pekerjaanPemohon']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///ALAMAT SAKSI 1
                                      CustomOutputForm(
                                        title: 'ALAMAT 1 (SATU)',
                                        subtitle: "${data['alamatSaksi1']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///DESA SAKSI 1
                                      CustomOutputForm(
                                        title: 'DESA/KELURAHAN 1 (SATU)',
                                        subtitle: "${data['desaSaksi1']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///KECAMATAN SAKSI 1
                                      CustomOutputForm(
                                        title: 'KECAMATAN SAKSI 1 (SATU)',
                                        subtitle: "${data['kecamatanSaksi1']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///KABUPATEN/KOTA SAKSI 1
                                      CustomOutputForm(
                                        title: 'KABUPATEN/KOTA SAKSI 1 (SATU)',
                                        subtitle: "${data['kabupatenSaksi1']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///PROVINSI PEMOHON
                                      CustomOutputForm(
                                        title: 'PROVINSI SAKSI 1 (SATU)',
                                        subtitle: "${data['provinsiPemohon']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///------------------------PROSES--------
                                      ///STATUS
                                      CustomOutputForm(
                                        title: 'STATUS',
                                        subtitle: "${data['proses']}",
                                      ),

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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                          Text(
                                            DateFormat(
                                              "hh:mm aaa",
                                              "id_ID",
                                            ).format(
                                              DateTime.parse(
                                                  "${data['updatedTime']}"),
                                            ),
                                            style: greyTextStyle.copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
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
                                        subtitle: "${data['nikSaksi1']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP SAKSI 1',
                                        subtitle:
                                            "${data['namaLengkapSaksi1']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NIK SAKSI 2',
                                        subtitle: "${data['nikSaksi2']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP SAKSI 2',
                                        subtitle:
                                            "${data['namaLengkapSaksi2']}",
                                      ),
                                      SizedBox(height: 10.h),

                                      ///PROSES
                                      CustomOutputForm(
                                        title: 'STATUS',
                                        subtitle: "${data['proses']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                          Text(
                                            DateFormat(
                                              "hh:mm aaa",
                                              "id_ID",
                                            ).format(
                                              DateTime.parse(
                                                  "${data['updatedTime']}"),
                                            ),
                                            style: greyTextStyle.copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
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
