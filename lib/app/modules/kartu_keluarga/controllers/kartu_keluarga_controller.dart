import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/theme.dart';

class KartuKeluargaController extends GetxController {
  RxInt currentStep = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  final ImagePicker imagePickerKK = ImagePicker();
  XFile? pickedImageKK;

  final ImagePicker imagePickerAktaPerkawinan = ImagePicker();
  XFile? pickedImageAktaPerkawinan;

  final ImagePicker imagePickerSuketDomisili = ImagePicker();
  XFile? pickedImageSuketDomisili;

  ///Kartu Keluarga

  TextEditingController noAktaKelahiranC = TextEditingController();
  TextEditingController noKkSemula = TextEditingController();
  TextEditingController provinsiC = TextEditingController();
  TextEditingController kabupatenKotaC = TextEditingController();
  TextEditingController rtC = TextEditingController();
  TextEditingController rwC = TextEditingController();
  TextEditingController kodePosC = TextEditingController();
  TextEditingController jenisKelaminC = TextEditingController();
  TextEditingController tglLahirC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController desaC = TextEditingController();
  TextEditingController jmlAnggotaFamylyC = TextEditingController();
  TextEditingController alasanPermohonanC = TextEditingController();
  TextEditingController noTeleponC = TextEditingController();
  TextEditingController daftarAnggotaC = TextEditingController();
  TextEditingController nikPemohonC = TextEditingController();
  TextEditingController namaLengkapPemohonC = TextEditingController();
  TextEditingController emailC = TextEditingController();

  ///ANGGOTA KELUARGA
  TextEditingController nikAnggota1 = TextEditingController();
  TextEditingController nikAnggota2 = TextEditingController();
  TextEditingController nikAnggota3 = TextEditingController();
  TextEditingController nikAnggota4 = TextEditingController();
  TextEditingController nikAnggota5 = TextEditingController();
  TextEditingController nikAnggota6 = TextEditingController();

  TextEditingController namaAnggota1 = TextEditingController();
  TextEditingController namaAnggota2 = TextEditingController();
  TextEditingController namaAnggota3 = TextEditingController();
  TextEditingController namaAnggota4 = TextEditingController();
  TextEditingController namaAnggota5 = TextEditingController();
  TextEditingController namaAnggota6 = TextEditingController();

  int index = 0;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  List<Map<String, dynamic>> alasanPermohonan = [
    {
      "alasanP": "Karena membentuk rumah tangga baru",
      "id": 1,
    },
    {
      "alasanP": "Karena kartu keluarga Hilang/Rusak",
      "id": 2,
    },
  ];

  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore2 = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? userPemohon = FirebaseAuth.instance.currentUser;

  void addKK() async {
    Random random = Random();
    int randomNumber = random.nextInt(100000) + 1;
    if (pickedImageKK != null && pickedImageAktaPerkawinan != null) {
      /// KK Lama
      String extKK = pickedImageKK!.name.split(".").last;

      await storage
          .ref('Kartu Keluarga')
          .child('KKlama$randomNumber.$extKK')
          .putFile(
            File(pickedImageKK!.path),
          );

      String fotoKK = await storage
          .ref('Kartu Keluarga')
          .child('KKlama$randomNumber.$extKK')
          .getDownloadURL();

      /// AKTA Perkawinan/BukuNIkah
      String extAktaPerkawinan =
          pickedImageAktaPerkawinan!.name.split(".").last;

      await storage
          .ref('Kartu Keluarga')
          .child('aktaPerkawinan$randomNumber.$extAktaPerkawinan')
          .putFile(
            File(pickedImageAktaPerkawinan!.path),
          );

      String fotoAktaPerkawinan = await storage
          .ref('Kartu Keluarga')
          .child('aktaPerkawinan$randomNumber.$extAktaPerkawinan')
          .getDownloadURL();

      ///SUKET DOMISILI
      String extSuketDomisili = pickedImageSuketDomisili!.name.split(".").last;

      await storage
          .ref('Kartu Keluarga')
          .child('suketDomisili$randomNumber.$extSuketDomisili')
          .putFile(
            File(pickedImageSuketDomisili!.path),
          );

      String fotoSuketDomisili = await storage
          .ref('Kartu Keluarga')
          .child('suketDomisili$randomNumber.$extSuketDomisili')
          .getDownloadURL();

      try {
        String uid = auth.currentUser!.uid;
        CollectionReference kartuKeluarga = firestore.collection('layanan');
        await kartuKeluarga.add({
          ///PEMOHON
          'nik': nikPemohonC.text,
          'namaLengkap': namaLengkapPemohonC.text,
          'noKKSemula': noKkSemula.text,
          'kabupaten/kota': kabupatenKotaC.text,
          'provinsi': provinsiC.text,
          'kecamatan': kecamatanC.text,
          'rt': rtC.text,
          'rw': rwC.text,
          'kodePos': kodePosC.text,
          'jmlAnggotaKeluarga': jmlAnggotaFamylyC.text,
          'desa': desaC.text,
          'noTelp': noTeleponC.text,
          'alasanPermohonan': alasanPermohonanC.text,
          'keyName': namaLengkapPemohonC.text.substring(0, 1).toUpperCase(),
          'keteranganKonfirmasi': '',
          'kategori': 'Kartu Keluarga',
          'email': userPemohon!.email,
          'uid': uid,
          'proses': 'PROSES VERIFIKASI',
          'creationTime': DateTime.now().toIso8601String(),
          'updatedTime': DateTime.now().toIso8601String(),

          ///NIK Anggota
          'nikAnggota1': nikAnggota1.text,
          'nikAnggota2': nikAnggota2.text,
          'nikAnggota3': nikAnggota3.text,
          'nikAnggota4': nikAnggota4.text,
          'nikAnggota5': nikAnggota5.text,
          'nikAnggota6': nikAnggota6.text,

          ///Nama Anggota
          'namaAnggota1': namaAnggota1.text,
          'namaAnggota2': namaAnggota2.text,
          'namaAnggota3': namaAnggota3.text,
          'namaAnggota4': namaAnggota4.text,
          'namaAnggota5': namaAnggota5.text,
          'namaAnggota6': namaAnggota6.text,

          /// Persyaratan
          'kkLama': fotoKK,
          'AktaPerkawinan/BukuNikah': fotoAktaPerkawinan,
          'suketDomisili': fotoSuketDomisili,
        });

        EasyLoading.showSuccess('Data Berhasil Ditambahakan');

        Get.offAllNamed(Routes.MAIN_PAGE);

        Get.back();
      } catch (e) {
        print(e);
        EasyLoading.showError(
          'Gagal mengirim data',
        );
      }
    } else {
      EasyLoading.showError(
        'Masukan file terlebihi dahulu',
      );
    }
  }

  void infoMsg(String msg1, String msg2) {
    Get.snackbar(
      msg1,
      msg2,
      backgroundColor: kBlackColor,
      colorText: kWhiteColor,
      snackPosition: SnackPosition.TOP,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  /// FOTO KK
  void selectImageKK() async {
    try {
      final dataImage = await imagePickerKK.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageKK = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKK = null;
      update();
    }
  }

  void resetImageKK() {
    pickedImageKK = null;
    update();
  }

  ///AKTA Perkawinan

  void selectImageAktaPerkawinan() async {
    try {
      final dataImage = await imagePickerAktaPerkawinan.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageAktaPerkawinan = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageAktaPerkawinan = null;
      update();
    }
  }

  void resetImageAktaPerkawinan() {
    pickedImageAktaPerkawinan = null;
    update();
  }

  ///SUKET DOMISILI
  void selectImageSuketDomisili() async {
    try {
      final dataImage = await imagePickerSuketDomisili.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageSuketDomisili = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageSuketDomisili = null;
      update();
    }
  }

  void resetImageSuketDomisli() {
    pickedImageSuketDomisili = null;
    update();
  }

  ///UNTUK FORM TANGGAL
  void dateLocal() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tglLahirC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }

  Future<Map<String, dynamic>?> getProfile() async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> docUser =
          await firestore.collection("pemohon").doc(uid).get();

      return docUser.data();
    } catch (e) {
      print(e);
      Get.snackbar("TERJADI KESALAHAN", "Tidak dapat get data user.");
      return null;
    }
  }
}
