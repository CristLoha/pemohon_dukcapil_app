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
                          height: 555.h,
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
                              height: 555.h,
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

                    ///KIA
                    if ("${data['kategori']}" == 'KIA')
                      Positioned(
                        top: 13,
                        child: Container(
                          width: 320.w,
                          height: 555.h,
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
                              height: 555.h,
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

                                      /// NIK
                                      CustomOutputForm(
                                        title: 'NIK ANAK',
                                        subtitle: "${data['nikAnak']}",
                                      ),
                                      SizedBox(height: 10.h),

                                      /// NOMOR AKTA KELAHIRAN
                                      CustomOutputForm(
                                        title: 'NOMOR AKTA KELAHIRAN ANAK',
                                        subtitle: "${data['noAktaKelahiran']}",
                                      ),
                                      SizedBox(height: 10.h),

                                      /// NAMA LENGKAP
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP ANAK',
                                        subtitle: "${data['namaLengkap']}",
                                      ),
                                      SizedBox(height: 10.h),

                                      /// JENIS KELAMIN
                                      CustomOutputForm(
                                        title: 'JENIS KELAMIN ANAK',
                                        subtitle: "${data['jenisKelamin']}",
                                      ),
                                      SizedBox(height: 10.h),

                                      ///TANGGAL LAHIR
                                      CustomOutputForm(
                                        title: 'TANGGAL LAHIR ANAK',
                                        subtitle: "${data['tgl_lahir']}",
                                      ),
                                      SizedBox(height: 10.h),

                                      ///KECAMATAN
                                      CustomOutputForm(
                                        title: 'KECAMATAN ANAK',
                                        subtitle: "${data['kecamatan']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'DESA ANAK',
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
                                        title: 'PEKERJAAN SAKSI 1 (SATU)',
                                        subtitle: "${data['pekerjaanSaksi1']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///ALAMAT SAKSI 1
                                      CustomOutputForm(
                                        title: 'ALAMA SAKSI 1 (SATU)',
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

                                      ///------------------------SAKSI 2--------
                                      ///NIK SAKSI 2
                                      CustomOutputForm(
                                        title: 'NIK SAKSI 2 (DUA)',
                                        subtitle: "${data['nikSaksi2']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///NAMA LENGKAP SAKSI 2
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP SAKSI 2 (DUA)',
                                        subtitle:
                                            "${data['namaLengkapSaksi2']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///TANGGAL LAHIR SAKSI 2
                                      CustomOutputForm(
                                        title: 'TANGGAL LAHIR SAKSI 2 (DUA)',
                                        subtitle:
                                            "${data['tanggalLahirSaksi2']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///PEKERJAAN SAKSI 2
                                      CustomOutputForm(
                                        title: 'PEKERJAAN SAKSI 2 (DUA)',
                                        subtitle: "${data['pekerjaanSaksi2']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///ALAMAT SAKSI 2
                                      CustomOutputForm(
                                        title: 'ALAMAT SAKSI 2 (DUA)',
                                        subtitle: "${data['alamatSaksi2']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///DESA SAKSI 2
                                      CustomOutputForm(
                                        title: 'DESA/KELURAHAN SAKSI 2 (DUA)',
                                        subtitle: "${data['desaSaksi2']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///KECAMATAN SAKSI 1
                                      CustomOutputForm(
                                        title: 'KECAMATAN SAKSI SAKSI 2 (DUA)',
                                        subtitle: "${data['kecamatanSaksi2']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///KABUPATEN/KOTA SAKSI 1
                                      CustomOutputForm(
                                        title: 'KABUPATEN/KOTA SAKSI 2 (DUA)',
                                        subtitle: "${data['kabupatenSaksi2']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///PROVINSI PEMOHON
                                      CustomOutputForm(
                                        title: 'PROVINSI SAKSI 2 (DUA)',
                                        subtitle: "${data['provinsiSaksi2']}",
                                      ),
                                      SizedBox(height: 10),

                                      ///------------------------PROSES--------
                                      ///STATUS
                                      CustomOutputForm(
                                        title: 'STATUS',
                                        subtitle: "${data['proses']}",
                                      ),

                                      ///TANGGAL KONFIRMASI
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
                                        title: 'NOMOR KK',
                                        subtitle: "${data['noKK']}",
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

                                      ///email
                                      CustomOutputForm(
                                        title: 'EMAIL',
                                        subtitle: "${data['email']}",
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
                                        title: 'NIK SAKSI 1 (SATU)',
                                        subtitle: "${data['nikSaksi1']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP SAKSI 1 (SATU)',
                                        subtitle:
                                            "${data['namaLengkapSaksi1']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NIK SAKSI 2 (DUA)',
                                        subtitle: "${data['nikSaksi2']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP SAKSI 2 (DUA)',
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

                                      ///TANGGAL KONFIRMASI
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

                    ///KARTU KELUARGA
                    if ("${data['kategori']}" == 'Kartu Keluarga')
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
                                        title: 'NIK',
                                        subtitle: "${data['nik']}",
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NAMA LENGKAP',
                                        subtitle: "${data['namaLengkap']}",
                                      ),

                                      ///NOMOR KK SEMULA
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NOMOR KK SEMULA',
                                        subtitle: "${data['noKKSemula']}",
                                      ),

                                      ///KABUPATEN/KOTA
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'KABUPATEN/KOTA',
                                        subtitle: "${data['kabupaten/kota']}",
                                      ),

                                      ///PROVINSI
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'PROVINSI',
                                        subtitle: "${data['provinsi']}",
                                      ),

                                      ///KECAMATAN
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'KECAMATAN',
                                        subtitle: "${data['kecamatan']}",
                                      ),

                                      ///DESA
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'DESA',
                                        subtitle: "${data['desa']}",
                                      ),

                                      ///RT/RW
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'RT/RW',
                                        subtitle: "${data['rt']}/${data['rw']}",
                                      ),

                                      ///KODE POS
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'KODE POS',
                                        subtitle: "${data['kodePos']}",
                                      ),

                                      ///JUMLAH ANGGOTA KELUARGA
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'JUMLAH ANGGOTA KELUARGA',
                                        subtitle:
                                            "${data['jmlAnggotaKeluarga']}",
                                      ),

                                      ///NOMOR TELEPON
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NOMOR TELEPON',
                                        subtitle: "${data['noTelp']}",
                                      ),

                                      ///ALASAN PERMOHONAN
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'ALASAN PERMOHONAN',
                                        subtitle: "${data['alasanPermohonan']}",
                                      ),

                                      ///NIK ANGGOTA 1
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NIK ANGGOTA 1',
                                        subtitle: "${data['nikAnggota1']}",
                                      ),

                                      ///NIK ANGGOTA 1
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NAMA ANGGOTA 1',
                                        subtitle: "${data['namaAnggota1']}",
                                      ),

                                      ///NIK ANGGOTA 2
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NIK ANGGOTA 2',
                                        subtitle: "${data['nikAnggota2']}",
                                      ),

                                      ///NIK ANGGOTA 2
                                      SizedBox(height: 10.h),
                                      CustomOutputForm(
                                        title: 'NAMA ANGGOTA 2',
                                        subtitle: "${data['namaAnggota2']}",
                                      ),

                                      ///NIK ANGGOTA 3
                                      SizedBox(height: 10.h),
                                      if ("${data['nikAnggota3']}".isEmpty)
                                        CustomOutputForm(
                                          title: 'NIK ANGGOTA 3',
                                          subtitle: "-",
                                        ),
                                      if ("${data['nikAnggota3']}".isNotEmpty)
                                        CustomOutputForm(
                                          title: 'NIK ANGGOTA 3',
                                          subtitle: "${data['nikAnggota3']}",
                                        ),

                                      ///NAMA ANGGOTA 3
                                      SizedBox(height: 10.h),
                                      if ("${data['namaAnggota3']}".isEmpty)
                                        CustomOutputForm(
                                          title: 'NAMA ANGGOTA 3',
                                          subtitle: "-",
                                        ),
                                      if ("${data['namaAnggota3']}".isNotEmpty)
                                        CustomOutputForm(
                                          title: 'NAMA ANGGOTA 3',
                                          subtitle: "${data['namaAnggota3']}",
                                        ),

                                      ///NIK ANGGOTA 4
                                      SizedBox(height: 10.h),
                                      if ("${data['nikAnggota4']}".isEmpty)
                                        CustomOutputForm(
                                          title: 'NIK ANGGOTA 4',
                                          subtitle: "-",
                                        ),
                                      if ("${data['nikAnggota4']}".isNotEmpty)
                                        CustomOutputForm(
                                          title: 'NIK ANGGOTA 4',
                                          subtitle: "${data['nikAnggota4']}",
                                        ),

                                      ///NAMA ANGGOTA 4
                                      SizedBox(height: 10.h),
                                      if ("${data['namaAnggota4']}".isEmpty)
                                        CustomOutputForm(
                                          title: 'NAMA ANGGOTA 4',
                                          subtitle: "-",
                                        ),
                                      if ("${data['namaAnggota4']}".isNotEmpty)
                                        CustomOutputForm(
                                          title: 'NAMA ANGGOTA 4',
                                          subtitle: "${data['namaAnggota4']}",
                                        ),

                                      ///NIK ANGGOTA 5
                                      SizedBox(height: 10.h),
                                      if ("${data['nikAnggota5']}".isEmpty)
                                        CustomOutputForm(
                                          title: 'NIK ANGGOTA 5',
                                          subtitle: "-",
                                        ),
                                      if ("${data['nikAnggota5']}".isNotEmpty)
                                        CustomOutputForm(
                                          title: 'NIK ANGGOTA 5',
                                          subtitle: "${data['nikAnggota5']}",
                                        ),

                                      ///NAMA ANGGOTA 5
                                      SizedBox(height: 10.h),
                                      if ("${data['namaAnggota5']}".isEmpty)
                                        CustomOutputForm(
                                          title: 'NAMA ANGGOTA 5',
                                          subtitle: "-",
                                        ),
                                      if ("${data['namaAnggota5']}".isNotEmpty)
                                        CustomOutputForm(
                                          title: 'NAMA ANGGOTA 5',
                                          subtitle: "${data['namaAnggota5']}",
                                        ),

                                      ///NIK ANGGOTA 6
                                      SizedBox(height: 10.h),
                                      if ("${data['nikAnggota6']}".isEmpty)
                                        CustomOutputForm(
                                          title: 'NIK ANGGOTA 6',
                                          subtitle: "-",
                                        ),
                                      if ("${data['nikAnggota6']}".isNotEmpty)
                                        CustomOutputForm(
                                          title: 'NIK ANGGOTA 6',
                                          subtitle: "${data['nikAnggota6']}",
                                        ),

                                      ///NAMA ANGGOTA 6
                                      SizedBox(height: 10.h),
                                      if ("${data['namaAnggota6']}".isEmpty)
                                        CustomOutputForm(
                                          title: 'NAMA ANGGOTA 6',
                                          subtitle: "-",
                                        ),
                                      if ("${data['namaAnggota6']}".isNotEmpty)
                                        CustomOutputForm(
                                          title: 'NAMA ANGGOTA 6',
                                          subtitle: "${data['namaAnggota6']}",
                                        ),

                                      SizedBox(height: 10.h),

                                      ///PROSES
                                      CustomOutputForm(
                                        title: 'STATUS',
                                        subtitle: "${data['proses']}",
                                      ),
                                      SizedBox(height: 10.h),

                                      ///TANGGAL KONFIRMASI
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
