import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/shared/theme.dart';
import 'package:photo_view/photo_view.dart';

import '../../../utils/custom_date_input.dart';
import '../../../utils/custom_form_input.dart';
import '../../../utils/custom_input_keterangan.dart';
import '../../../utils/custom_tittle_form.dart';
import '../controllers/edit_dokumen_controller.dart';

class EditDokumenView extends GetView<EditDokumenController> {
  @override
  Widget build(BuildContext context) {
    Widget updateKTP() {
      return Center(
        child: Container(
          height: 50.h,
          margin: EdgeInsets.only(top: 30.h),
          child: Container(
            child: ElevatedButton(
              onPressed: () async {
                await EasyLoading.show(status: 'memuat...');
                controller.editPerekamanKtp(
                  controller.namaC.text,
                  controller.keteranganC.text,
                  controller.kabupatenC.text,
                  controller.kecamatanC.text,
                  controller.provinsiC.text,
                  Get.arguments,
                );
                EasyLoading.dismiss();
                EasyLoading.showSuccess('Dokumen Berhasil Diperbaharui');
                Get.back();
              },
              child: Text(
                'Perbarui Profile',
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
        ),
      );
    }

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
                  controller.nikC.text = data["nik"];
                  controller.namaC.text = data["nama"];
                  controller.noTeleponC.text = data["noTelpon"];
                  controller.tanggalC.text = data["tgl_lahir"];
                  controller.provinsiC.text = data["provinsi"];
                  controller.kabupatenC.text = data["kabupaten"];
                  controller.kecamatanC.text = data["kecamatan"];
                  controller.desaC.text = data["desa"];
                  controller.keteranganC.text = data["keterangan"];
                  // tampilkan form untuk Perekaman e-KTP
                }
              }
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  ///perekaman eKTP
                  if ("${data['kategori']}" == 'Perekaman e-KTP')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///NIK
                        CustomTitleWidget(title: 'NIK'),
                        SizedBox(height: 12.h),
                        CustomFormField(
                          readOnly: false,
                          textCapitalization: TextCapitalization.none,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          textEditingController: controller.nikC,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Input tidak boleh kosong";
                            } else if (!GetUtils.isLengthEqualTo(value, 16)) {
                              return 'NIK harus 16 karakter';
                            }
                            return null;
                          },
                        ),

                        ///NAMA LENGKAP
                        SizedBox(height: 20.h),
                        CustomTitleWidget(title: 'Nama Lengkap'),
                        SizedBox(height: 12.h),
                        CustomFormField(
                          readOnly: false,
                          textEditingController: controller.namaC,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Input tidak boleh kosong";
                            } else {
                              return null;
                            }
                          },
                          textCapitalization: TextCapitalization.words,
                        ),

                        ///NOMOR TELEPON
                        SizedBox(height: 20.h),
                        CustomTitleWidget(title: 'Nomor Telepon'),
                        SizedBox(height: 12.h),
                        CustomFormField(
                          readOnly: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Input tidak boleh kosong";
                            } else {
                              return null;
                            }
                          },
                          textEditingController: controller.noTeleponC,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                        ),

                        ///tanggal lahir
                        SizedBox(height: 20.h),
                        CustomTitleWidget(title: 'Tanggal lahir'),
                        SizedBox(height: 12.h),
                        CustomDateInput(
                            onTap: () => controller.dateLocal(),
                            controller: controller.tanggalC),

                        ///PROVINSI
                        SizedBox(height: 20.h),
                        CustomTitleWidget(title: 'Provinsi'),
                        SizedBox(height: 12.h),
                        CustomFormField(
                          readOnly: true,
                          textEditingController: controller.provinsiC,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Input tidak boleh kosong";
                            } else {
                              return null;
                            }
                          },
                          textCapitalization: TextCapitalization.words,
                        ),

                        ///KABUPATEN
                        SizedBox(height: 20.h),
                        CustomTitleWidget(title: 'Kabupaten'),
                        SizedBox(height: 12.h),
                        CustomFormField(
                          readOnly: true,
                          textEditingController: controller.kabupatenC,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Input tidak boleh kosong";
                            } else {
                              return null;
                            }
                          },
                          textCapitalization: TextCapitalization.words,
                        ),

                        ///KECAMATAN
                        SizedBox(height: 20.h),
                        CustomTitleWidget(title: 'Kecamatan'),
                        SizedBox(height: 12.h),
                        CustomFormField(
                          readOnly: true,
                          textEditingController: controller.kecamatanC,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Input tidak boleh kosong";
                            } else {
                              return null;
                            }
                          },
                          textCapitalization: TextCapitalization.words,
                        ),

                        ///Desa
                        SizedBox(height: 20.h),
                        CustomTitleWidget(title: 'Desa'),
                        SizedBox(height: 12.h),
                        CustomFormField(
                          readOnly: true,
                          textEditingController: controller.desaC,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Input tidak boleh kosong";
                            } else {
                              return null;
                            }
                          },
                          textCapitalization: TextCapitalization.words,
                        ),

                        ///Keterangan
                        SizedBox(height: 20.h),
                        CustomTitleWidget(title: 'Keterangan'),
                        SizedBox(height: 12.h),
                        CustomFormKeteranganField(
                          readOnly: false,
                          textInputAction: TextInputAction.done,
                          textEditingController: controller.keteranganC,
                        ),

                        ///KK
                        SizedBox(height: 20),
                        Text(
                          'Unggah KK',
                          style: blackTextStyle.copyWith(),
                        ),
                        SizedBox(height: 12.h),
                        Center(
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 15, top: 20, right: 10),
                            width: 315.w,
                            height: 140.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kGreyColor,
                              ),
                            ),
                            child: Column(
                              children: [
                                GetBuilder<EditDokumenController>(
                                  builder: (c) => c.pickedImageKtp != null
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                c.pickedImageKtp!.name,
                                                style:
                                                    blackTextStyle.copyWith(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () => c.resetImage(),
                                              child: Icon(
                                                Icons.delete,
                                                color: kRedColor,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          '*Maks 5 Mb',
                                          style: redTextStyle.copyWith(),
                                        ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 120.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: GetBuilder<EditDokumenController>(
                                        builder: (c) {
                                          return c.pickedImageKtp != null
                                              ? ElevatedButton(
                                                  onPressed: () {
                                                    Get.dialog(
                                                      Container(
                                                        child: PhotoView(
                                                          imageProvider:
                                                              FileImage(
                                                            File(c
                                                                .pickedImageKtp!
                                                                .path),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    'Lihat',
                                                    style:
                                                        blackTextStyle.copyWith(
                                                      fontSize: 16.sp,
                                                      fontWeight: medium,
                                                    ),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                      side: BorderSide(
                                                        color: kGreyColor,
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        kWhiteColor,
                                                  ),
                                                )
                                              : snapshot.data?["fotoKK"] != null
                                                  ? ElevatedButton(
                                                      onPressed: () {
                                                        Get.dialog(
                                                          Container(
                                                            child: PhotoView(
                                                              imageProvider:
                                                                  NetworkImage(
                                                                snapshot.data![
                                                                    "fotoKK"],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        'Lihat',
                                                        style: blackTextStyle
                                                            .copyWith(
                                                          fontSize: 16.sp,
                                                          fontWeight: medium,
                                                        ),
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
                                                          side: BorderSide(
                                                            color: kGreyColor,
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            kWhiteColor,
                                                      ))
                                                  : ElevatedButton(
                                                      onPressed: () {
                                                        EasyLoading.showError(
                                                          'Masukan file terlebihi dahulu',
                                                        );
                                                      },
                                                      child: Text(
                                                        'Lihat',
                                                        style: blackTextStyle
                                                            .copyWith(
                                                          fontSize: 16.sp,
                                                          fontWeight: medium,
                                                        ),
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
                                                          side: BorderSide(
                                                            color: kGreyColor,
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            kWhiteColor,
                                                      ));
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: 120.w,
                                      height: 40.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.selectImage();
                                        },
                                        child: Text(
                                          'Pilih File',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: medium,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            side: BorderSide(
                                              color: kGreyColor,
                                            ),
                                          ),
                                          backgroundColor: kWhiteColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        updateKTP(),
                      ],
                    ),

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
