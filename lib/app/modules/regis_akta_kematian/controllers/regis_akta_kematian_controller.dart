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

class RegisAktaKematianController extends GetxController {
  RxInt currentStep = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final ImagePicker imagePickerKTPJenazah = ImagePicker();
  XFile? pickedImageKTPJenazah;

  final ImagePicker imagePickerKK = ImagePicker();
  XFile? pickedImageKK;

  final ImagePicker imagePickerAktaKelahiran = ImagePicker();
  XFile? pickedImageAktaKelahiran;

  final ImagePicker imagePickerKTPPelapor = ImagePicker();
  XFile? pickedImageKtpPelapor;

  final ImagePicker imagePickerKKPelapor = ImagePicker();
  XFile? pickedImageKKPelapor;

  /// JENAZAH
  TextEditingController nikJenazahC = TextEditingController();
  TextEditingController namaLengkapJenazahC = TextEditingController();
  TextEditingController jenisKelaminJenazahC = TextEditingController();
  TextEditingController tglLahirJenazajC = TextEditingController();
  TextEditingController tempatLahirC = TextEditingController();
  TextEditingController agamaJenazah = TextEditingController();
  TextEditingController anakKe = TextEditingController();
  TextEditingController pekerjaanJenazahC = TextEditingController();
  TextEditingController alamatJenazahC = TextEditingController();
  TextEditingController desaJenazahC = TextEditingController();
  TextEditingController kecamatanJenazahC = TextEditingController();
  TextEditingController kabupatenJenazahC = TextEditingController();
  TextEditingController provinsiJenazahC = TextEditingController();
  TextEditingController kodePosC = TextEditingController();
  TextEditingController tanggalKematianC = TextEditingController();
  TextEditingController pukulC = TextEditingController();
  TextEditingController sebabKematianC = TextEditingController();
  TextEditingController tempatKematianC = TextEditingController();
  TextEditingController menerangkanC = TextEditingController();

  ///AYAH
  TextEditingController noKepalaKeluargaC = TextEditingController();
  TextEditingController nikAyahC = TextEditingController();
  TextEditingController namaLengkapAyahC = TextEditingController();
  TextEditingController tanggalLahirAyahC = TextEditingController();
  TextEditingController pekerjaanAyahC = TextEditingController();
  TextEditingController alamatAyah = TextEditingController();
  TextEditingController desaAyah = TextEditingController();
  TextEditingController kecamatanAyahC = TextEditingController();
  TextEditingController kabupatenAyahC = TextEditingController();
  TextEditingController provinsiAyahC = TextEditingController();

  ///IBU
  TextEditingController nikIbuC = TextEditingController();
  TextEditingController namaLengkapIbuC = TextEditingController();
  TextEditingController tanggalLahirIbuC = TextEditingController();
  TextEditingController pekerjaanIbuC = TextEditingController();
  TextEditingController alamatIbu = TextEditingController();
  TextEditingController desaIbu = TextEditingController();
  TextEditingController kecamatanIbuC = TextEditingController();
  TextEditingController kabupatenIbuC = TextEditingController();
  TextEditingController provinsiIbuC = TextEditingController();

  /// PEMOHON
  TextEditingController nikPemohonC = TextEditingController();
  TextEditingController namaLengkapPemohonC = TextEditingController();
  TextEditingController tanggalLahirPemohonC = TextEditingController();
  TextEditingController pekerjaanPemohonC = TextEditingController();
  TextEditingController alamatPemohon = TextEditingController();
  TextEditingController desaPemohon = TextEditingController();
  TextEditingController kecamatanPemohonC = TextEditingController();
  TextEditingController kabupatenPemohonC = TextEditingController();
  TextEditingController provinsiPemohonC = TextEditingController();

  /// SAKSI1
  TextEditingController nikSaksi1C = TextEditingController();
  TextEditingController namaLengkapSaksi1C = TextEditingController();
  TextEditingController tanggalLahirSaksi1C = TextEditingController();
  TextEditingController pekerjaanSaksi1C = TextEditingController();
  TextEditingController alamatSaksi1C = TextEditingController();
  TextEditingController desaPemohonSaksi1 = TextEditingController();
  TextEditingController kecamatanSaksi1C = TextEditingController();
  TextEditingController kabupatenSaksi1C = TextEditingController();
  TextEditingController provinsiSaksi1C = TextEditingController();

  /// SAKSI2
  TextEditingController nikSaksi2C = TextEditingController();
  TextEditingController namaLengkapSaksi2C = TextEditingController();
  TextEditingController tanggalLahirSaksi2C = TextEditingController();
  TextEditingController pekerjaanSaksi2C = TextEditingController();
  TextEditingController alamatSaksi2C = TextEditingController();
  TextEditingController desaPemohonSaksi2 = TextEditingController();
  TextEditingController kecamatanSaksi2C = TextEditingController();
  TextEditingController kabupatenSaksi2C = TextEditingController();
  TextEditingController provinsiSaksi2C = TextEditingController();
  int index = 0;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  List<Map<String, dynamic>> dataJenisKelamin = [
    {
      "jenisKelamin": "LAKI-LAKI",
      "id": 1,
    },
    {
      "jenisKelamin": "PEREMPUAN",
      "id": 2,
    }
  ];

  List<Map<String, dynamic>> dataJenisKewarganegaraan = [
    {
      "jenisK": "WNI",
      "id": 1,
    },
    {
      "jenisK": "WNA",
      "id": 2,
    }
  ];

  List<Map<String, dynamic>> dataJenisYgMenerangkan = [
    {
      "menerangkan": "DOKTER",
      "id": 1,
    },
    {
      "menerangkan": "POLISI",
      "id": 2,
    }
  ];

  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore2 = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? userPemohon = FirebaseAuth.instance.currentUser;

  void addPerubahanKTP() async {
    Random random = Random();
    int randomNumber = random.nextInt(100000) + 1;
    if (pickedImageKTPJenazah != null &&
        pickedImageAktaKelahiran != null &&
        pickedImageKtpPelapor != null) {
      /// KTP Jenazah
      String extKTPJenazah = pickedImageKTPJenazah!.name.split(".").last;

      await storage
          .ref('aktaKematian')
          .child('KTPJenazah$randomNumber.$extKTPJenazah')
          .putFile(
            File(pickedImageKTPJenazah!.path),
          );

      String ktpJenazah = await storage
          .ref('aktaKematian')
          .child('KTPJenazah$randomNumber.$extKTPJenazah')
          .getDownloadURL();

      /// KK
      String extKK = pickedImageKK!.name.split(".").last;

      await storage.ref('aktaKematian').child('KK$randomNumber.$extKK').putFile(
            File(pickedImageKK!.path),
          );

      String fotoKK = await storage
          .ref('aktaKematian')
          .child('KK$randomNumber.$extKK')
          .getDownloadURL();

      /// AKTAkelahiran
      String extAktaKelahiran = pickedImageAktaKelahiran!.name.split(".").last;

      await storage
          .ref('aktaKematian')
          .child('AktaKelahiran$randomNumber.$extAktaKelahiran')
          .putFile(
            File(pickedImageAktaKelahiran!.path),
          );

      String fotoAktaKelahiran = await storage
          .ref('aktaKematian')
          .child('AktaKelahiran$randomNumber.$extKK')
          .getDownloadURL();

      /// KTP Pelapor
      String extKtPPelapor = pickedImageKtpPelapor!.name.split(".").last;

      await storage
          .ref('aktaKematian')
          .child('KtpPelapor$randomNumber.$extKtPPelapor')
          .putFile(
            File(pickedImageKtpPelapor!.path),
          );

      String ktpPelaPor = await storage
          .ref('aktaKematian')
          .child('KtpPelapor$randomNumber.$extKtPPelapor')
          .getDownloadURL();

      /// KKPelapor
      String extKKpelapor = pickedImageKKPelapor!.name.split(".").last;

      await storage
          .ref('aktaKematian')
          .child('KKpelapor$randomNumber.$extKKpelapor')
          .putFile(
            File(pickedImageKKPelapor!.path),
          );

      String fotoKKpelapor = await storage
          .ref('aktaKematian')
          .child('KKpelapor$randomNumber.$extKKpelapor')
          .getDownloadURL();

      try {
        String uid = auth.currentUser!.uid;
        CollectionReference rekamanKtp = firestore.collection('layanan');
        await rekamanKtp.add({
          ///JENAZAH
          'nikJenazah': nikJenazahC.text,
          'namaLengkapJenazah': namaLengkapJenazahC.text,
          'jenisKelaminJenazah': jenisKelaminJenazahC.text,
          'tgl_lahirJenasah': tglLahirJenazajC.text,
          'tempatLahirJenazah': tglLahirJenazajC.text,
          'agamaJenazah': agamaJenazah.text,
          'pekerjaanJenazah': pekerjaanJenazahC.text,
          'alamatJenazah': alamatJenazahC.text,
          'desaJenazah': desaJenazahC.text,
          'kecamatanJenazah': kecamatanJenazahC.text,
          'kabupatenJenazah': kecamatanJenazahC.text,
          'provinsiJenazah': provinsiJenazahC.text,

          // ///PEMOHON
          // 'nikPemohon': nikC.text,
          // 'namaPemohon': nameC.text,
          // 'email': userPemohon!.email,
          // 'keterangan': keteranganC.text,
          // "keyName": nameC.text.substring(0, 1).toUpperCase(),

          ///PERSYARATAN
          'fotoKK': fotoKK,
          'fotoAktaKelahiran': fotoAktaKelahiran,
          'fotoKTPJenazah': ktpJenazah,
          'fotoKTPPelapor': ktpPelaPor,
          'fotoKKPelapor': fotoKKpelapor,

          ///PROSES
          'kategori': 'Akta Kematian',

          'uid': uid,
          'proses': 'PROSES VERIFIKASI',
          'creationTime': DateTime.now().toIso8601String(),
          'updatedTime': DateTime.now().toIso8601String(),
        });

        EasyLoading.showSuccess('Data Berhasil Ditambahakan');

        Get.offAllNamed(Routes.MAIN_PAGE);

        Get.back();
      } catch (e) {
        print(e);
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

  /// FOTO KTP JENAZAH
  void selectImageKTPJenazah() async {
    try {
      final dataImage = await imagePickerKTPJenazah.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageKTPJenazah = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKTPJenazah = null;
      update();
    }
  }

  void resetImageKTPJenazah() {
    pickedImageKTPJenazah = null;
    update();
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

  ///AKTA KELAHIRAN

  void selectImageAktaKelahiran() async {
    try {
      final dataImage = await imagePickerAktaKelahiran.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageAktaKelahiran = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageAktaKelahiran = null;
      update();
    }
  }

  void resetImageAktaKelahiran() {
    pickedImageAktaKelahiran = null;
    update();
  }

  /// KTP PELAPOR
  void selectKtpPelapor() async {
    try {
      final dataImage = await imagePickerKTPPelapor.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageKtpPelapor = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKtpPelapor = null;
      update();
    }
  }

  void resetImageKtpPelapor() {
    pickedImageKtpPelapor = null;
    update();
  }

  /// KK PELAPOR

  void selectKKPelapor() async {
    try {
      final dataImage = await imagePickerKKPelapor.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageKKPelapor = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKKPelapor = null;
      update();
    }
  }

  void resetImageKKPelapor() {
    pickedImageKKPelapor = null;
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
        dateC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }

  void dateKematian() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tanggalKematianC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
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
