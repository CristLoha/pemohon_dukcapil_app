import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/theme.dart';

class AktaKelahiranController extends GetxController {
  RxInt currentStep = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;

  /// BAYI/ANAK
  TextEditingController nameAnakC = TextEditingController();
  TextEditingController jenisKelaminC = TextEditingController();
  TextEditingController tempatDilahirkanC = TextEditingController();
  TextEditingController tempatKelahiranC = TextEditingController();
  TextEditingController kelahiranKeC = TextEditingController();
  TextEditingController tglLahirAnakC = TextEditingController();
  TextEditingController pukulC = TextEditingController();
  TextEditingController beratBayiC = TextEditingController();
  TextEditingController panjangBayiC = TextEditingController();
  TextEditingController jenisKelahiranC = TextEditingController();
  TextEditingController penolongKelahiranC = TextEditingController();

  ///IBU
  TextEditingController nikIbuC = TextEditingController();
  TextEditingController namaLengkapIbuC = TextEditingController();
  TextEditingController tanggalLahirIbuC = TextEditingController();
  TextEditingController tglPencatatanPerkawinanC = TextEditingController();
  TextEditingController pekerjaanIbu = TextEditingController();
  TextEditingController desaIbuC = TextEditingController();
  TextEditingController kecamatanIbuC = TextEditingController();
  TextEditingController kabupatenIbuC = TextEditingController();
  TextEditingController provinsiIbuC = TextEditingController();
  TextEditingController kewarganegaraanIbuC = TextEditingController();
  TextEditingController kebangsaanC = TextEditingController();

  ///AYAH
  TextEditingController nikAyahC = TextEditingController();
  TextEditingController namaLengkapAyahC = TextEditingController();
  TextEditingController tanggalLahirAyahC = TextEditingController();
  TextEditingController pekerjaanAyah = TextEditingController();
  TextEditingController desaAyah = TextEditingController();
  TextEditingController kecamatanAyahC = TextEditingController();
  TextEditingController kabupatenAyahC = TextEditingController();
  TextEditingController noKKC = TextEditingController();
  TextEditingController provinsiAyahC = TextEditingController();
  TextEditingController kewarganegaraanAyah = TextEditingController();
  TextEditingController kebangsaanAyahC = TextEditingController();

  /// PEMOHON
  TextEditingController nikPemohonC = TextEditingController();
  TextEditingController namaLengkapPemohonC = TextEditingController();
  TextEditingController emailPemohonC = TextEditingController();
  TextEditingController noTelpPemohonC = TextEditingController();
  TextEditingController tglLahirPemohonC = TextEditingController();
  TextEditingController jenisKelaminPemohonC = TextEditingController();
  TextEditingController pekerjaanPemohonC = TextEditingController();
  TextEditingController desaPemohonC = TextEditingController();
  TextEditingController kecamatanPemohonC = TextEditingController();
  TextEditingController kabupatenPemohonC = TextEditingController();
  TextEditingController provinsiPemohonC = TextEditingController();
  TextEditingController kewarganegaraanPemohonC = TextEditingController();

  /// SAKSI1
  TextEditingController nikSaksi1C = TextEditingController();
  TextEditingController namaLengkapSaksi1C = TextEditingController();
  TextEditingController tglLahirSaksi1C = TextEditingController();
  TextEditingController jenisKelaminSaksi1C = TextEditingController();
  TextEditingController pekerjaanSaksi1C = TextEditingController();
  TextEditingController desaSaksi1C = TextEditingController();
  TextEditingController kecamatanSaksi1C = TextEditingController();
  TextEditingController kabupatenSaksi1C = TextEditingController();
  TextEditingController provinsiSaksi1C = TextEditingController();

  /// SAKSI2
  TextEditingController nikSaksi2C = TextEditingController();
  TextEditingController namaLengkapSaksi2C = TextEditingController();
  TextEditingController tglLahirSaksi2C = TextEditingController();
  TextEditingController jenisKelaminSaksi2C = TextEditingController();
  TextEditingController pekerjaanSaksi2C = TextEditingController();
  TextEditingController desaSaksi2C = TextEditingController();
  TextEditingController kecamatanSaksi2C = TextEditingController();
  TextEditingController kabupatenSaksi2C = TextEditingController();
  TextEditingController provinsiSaksi2C = TextEditingController();

  TextEditingController keteranganC = TextEditingController();

  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
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

  List<Map<String, dynamic>> jenisKelahiran = [
    {
      "jnsKelahiran": "Tunggal",
      "id": 1,
    },
    {
      "jnsKelahiran": "Kembar 2",
      "id": 2,
    },
    {
      "jnsKelahiran": "Kembar 3",
      "id": 3,
    },
    {
      "jnsKelahiran": "Kembar 4",
      "id": 4,
    },
    {
      "jnsKelahiran": "Lainnya",
      "id": 5,
    },
  ];

  List<Map<String, dynamic>> penolongKelahiran = [
    {
      "pKelahiran": "Dokter",
      "id": 1,
    },
    {
      "pKelahiran": "Bidan/Perawat",
      "id": 2,
    },
    {
      "pKelahiran": "Dukun",
      "id": 3,
    },
    {
      "pKelahiran": "Lainnya",
      "id": 4,
    },
  ];

  List<Map<String, dynamic>> tempatDilahirkan = [
    {
      "tmptDilahirkan": "RS/RB",
      "id": 1,
    },
    {
      "tmptDilahirkan": "Puskesmas",
      "id": 2,
    },
    {
      "tmptDilahirkan": "Polindes",
      "id": 3,
    },
    {
      "tmptDilahirkan": "Rumah",
      "id": 4,
    },
    {
      "tmptDilahirkan": "Lainnya",
      "id": 5,
    },
  ];

  XFile? pickedImageSuket;
  final ImagePicker imagePickerSuket = ImagePicker();
  XFile? pickedImageKK;
  final ImagePicker imagePickerKK = ImagePicker();
  XFile? pickedImageAktaNikah;
  final ImagePicker imagePickerAktaNikah = ImagePicker();

  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore2 = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? userPemohon = FirebaseAuth.instance.currentUser;

  void addreAktaKelahiran() async {
    String uid = auth.currentUser!.uid;
    Random random = Random();
    int randomNumber = random.nextInt(100000) + 1;
    if (pickedImageKK != null &&
        pickedImageSuket != null &&
        pickedImageAktaNikah != null) {
      ///SUKET
      String extSuket = pickedImageSuket!.name.split(".").last;
      await storage
          .ref(
            'AktaKelahiran',
          )
          .child('Suket$randomNumber.$extSuket')
          .putFile(
            File(
              pickedImageSuket!.path,
            ),
          );

      String fotoSuket = await storage
          .ref('AktaKelahiran')
          .child('Suket$randomNumber.$extSuket')
          .getDownloadURL();

      ///KK
      String extKK = pickedImageKK!.name.split(".").last;
      await storage
          .ref('AktaKelahiran')
          .child('KK$randomNumber.$extKK')
          .putFile(
            File(
              pickedImageKK!.path,
            ),
          );

      String fotoKK = await storage
          .ref('AktaKelahiran')
          .child('KK$randomNumber.$extKK')
          .getDownloadURL();

      ///AKTA NIKAH

      String extAktaNikah = pickedImageAktaNikah!.name.split(".").last;
      await storage
          .ref('AktaKelahiran')
          .child('AktaNikah$randomNumber.$extKK')
          .putFile(
            File(
              pickedImageAktaNikah!.path,
            ),
          );

      String fotoAktaNikah = await storage
          .ref('AktaKelahiran')
          .child('AktaNikah$randomNumber.$extAktaNikah')
          .getDownloadURL();

      CollectionReference rekamanKtp = firestore.collection('layanan');

      await rekamanKtp.add({
        ///BAYI/ANAK
        "namaAnak": nameAnakC.text,
        "jenisKelaminAnak": jenisKelaminC.text,
        "penolongKelahiran": penolongKelahiranC.text,
        "tempatDilahirkan": tempatDilahirkanC.text,
        "tempatKelahiran": tempatKelahiranC.text,
        "kelahiranKe": kelahiranKeC.text,
        "tglLahirAnak": tglLahirAnakC.text,
        "pukul": pukulC.text,
        "jenisKelahiran": jenisKelahiranC.text,
        "beratBayi": beratBayiC.text,
        "panjangBayi": panjangBayiC.text,

        ///IBU
        "nikIbu": nikIbuC.text,
        "namaLengkapIbu": namaLengkapIbuC.text,
        "tanggalLahirIbu": tanggalLahirIbuC.text,
        "pekerjaanIbu": pekerjaanIbu.text,
        "desaIbu": desaIbuC.text,
        "kecamatanIbu": kecamatanIbuC.text,
        "kabupatenIbu": kabupatenIbuC.text,
        "provinsiIbu": provinsiIbuC.text,
        "kewarganegaraanIbu": kewarganegaraanIbuC.text,
        "kebangsaanIbu": kebangsaanC.text,
        "tglPerkawinan": tglPencatatanPerkawinanC.text,

        ///AYAH
        "nikAyah": nikAyahC.text,
        "namaLengkapAyah": namaLengkapAyahC.text,
        "tanggalLahirAyah": tanggalLahirAyahC.text,
        "pekerjaanAyah": pekerjaanAyah.text,
        "desaAyah": desaIbuC.text,
        "noKK": noKKC.text,
        "kecamatanAyah": kecamatanAyahC.text,
        "kabupatenAyah": kabupatenAyahC.text,
        "provinsiAyah": provinsiAyahC.text,
        "kewarganegaraanAyah": kewarganegaraanAyah.text,
        "kebangsaanAyah": kebangsaanAyahC.text,

        ///PEMOHON
        "nikPemohon": nikPemohonC.text,
        "namaLengkapPemohon": namaLengkapPemohonC.text,
        "tanggalLahirPemohon": tglLahirPemohonC.text,
        "jenisKelaminPemohon": jenisKelaminPemohonC.text,
        "pekerjaanPemohon": pekerjaanPemohonC.text,
        "desaPemohon": desaPemohonC.text,
        "kecamatanPemohon": kecamatanPemohonC.text,
        "kabupatenPemohon": kabupatenPemohonC.text,
        "provinsiPemohon": provinsiPemohonC.text,
        "kewarganegaraanPemohon": provinsiPemohonC.text,
        "noTelp": noTelpPemohonC.text,
        "email": userPemohon!.email,
        "keyName": namaLengkapPemohonC.text.substring(0, 1).toUpperCase(),

        ///SAKSI 1
        "nikSaksi1": nikSaksi1C.text,
        "namaLengkapSaksi1": namaLengkapSaksi1C.text,
        "tanggalLahirSaksi1": tglLahirSaksi1C.text,
        "jenisKelaminSaksi1": jenisKelaminSaksi1C.text,
        "pekerjaanSaksi1": pekerjaanSaksi1C.text,
        "desaSaksi1": desaSaksi1C.text,
        "kecamatanSaksi1": kecamatanSaksi1C.text,
        "kabupatenSaksi1": kabupatenSaksi1C.text,
        "provinsiSaksi1": provinsiSaksi1C.text,

        ///SAKSI 2
        "nikSaksi2": nikSaksi2C.text,
        "namaLengkapSaksi2": namaLengkapSaksi2C.text,
        "tanggalLahirSaksi2": tglLahirSaksi2C.text,
        "jenisKelaminSaksi2": jenisKelaminSaksi2C.text,
        "pekerjaanSaksi2": pekerjaanSaksi2C.text,
        "desaSaksi2": desaSaksi2C.text,
        "kecamatanSaksi2": kecamatanSaksi1C.text,
        "kabupatenSaksi2": kabupatenSaksi2C.text,
        "provinsiSaksi2": provinsiSaksi2C.text,

        ///PERSYARATAN
        "fotoSuket": fotoSuket,
        "fotoKK": fotoKK,
        "aktaNikah": fotoAktaNikah,

        ///PROSES
        'kategori': 'Akta Kelahiran',
        'uid': uid,
        'keteranganKonfirmasi': '',
        'proses': 'PROSES VERIFIKASI',
        'creationTime': DateTime.now().toIso8601String(),
        'updatedTime': DateTime.now().toIso8601String(),
      }).then(
        (value) {
          EasyLoading.showSuccess('Data Berhasil Ditambahakan');
          Get.offAllNamed(Routes.MAIN_PAGE);
        },
      ).catchError(
        (error) {
          print("Failed to add user: $error");
        },
      );
    } else {
      EasyLoading.showError(
        'Masukan file persyaratan terlebihi dahulu',
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

  ///SUKET
  void selectImageSuket() async {
    try {
      final dataImage = await imagePickerSuket.pickImage(
        source: ImageSource.gallery,
      );
      if (dataImage != null) {
        print(dataImage.path);
        final file = File(dataImage.path);
        final sizeInBytes = file.lengthSync();
        if (sizeInBytes > 5 * 1024 * 1024) {
          EasyLoading.showError(
              'Ukuran file terlalu besar, harap pilih file dengan ukuran kurang dari 5 MB',
              duration: Duration(seconds: 5));
        } else {
          pickedImageSuket = dataImage;
        }
      }
      update();
    } catch (err) {
      print(err);
      pickedImageSuket = null;
      update();
    }
  }

  void resetImageSuket() {
    pickedImageSuket = null;
    update();
  }

  ///KK
  void selectImageKK() async {
    try {
      final dataImage = await imagePickerKK.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.path);
        final file = File(dataImage.path);
        final sizeInBytes = file.lengthSync();
        if (sizeInBytes > 5 * 1024 * 1024) {
          EasyLoading.showError(
              'Ukuran file terlalu besar, harap pilih file dengan ukuran kurang dari 5 MB',
              duration: Duration(seconds: 5));
        } else {
          pickedImageKK = dataImage;
        }
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

  ///AKTA NIKAH
  void selectImageAktaNikah() async {
    try {
      final dataImage = await imagePickerAktaNikah.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.path);
        final file = File(dataImage.path);
        final sizeInBytes = file.lengthSync();
        if (sizeInBytes > 5 * 1024 * 1024) {
          EasyLoading.showError(
              'Ukuran file terlalu besar, harap pilih file dengan ukuran kurang dari 5 MB',
              duration: Duration(seconds: 5));
        } else {
          pickedImageAktaNikah = dataImage;
        }
      }
      update();
    } catch (err) {
      print(err);
      pickedImageAktaNikah = null;
      update();
    }
  }

  void resetImageAktaNikah() {
    pickedImageAktaNikah = null;
    update();
  }

  ///tgl lahir anak
  void tglLahirAnak() async {
    final DateTime? selectedDate = await showDatePicker(
      context: Get.context!,
      firstDate: DateTime(1960, 1, 1),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      tglLahirAnakC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  ///tglLahirIbu
  void tglLahirIbu() async {
    final DateTime? selectedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960, 1, 1),
      lastDate: DateTime(2024, 12, 31),
    );
    if (selectedDate != null) {
      tanggalLahirIbuC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  ///TglLahirAyah

  void tglLahirAyah() async {
    final DateTime? selectedDate = await showDatePicker(
        context: Get.context!,
        firstDate: DateTime(1960, 1, 1),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      tanggalLahirAyahC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  ///tgl lahir pemohon
  void tglLahirPemohon() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tglLahirPemohonC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }

  ///tgl lahir saksi1
  void tglLahirSaksi1() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tglLahirSaksi1C.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }

  ///tgl lahir saksi2
  void tglLahirSaksi2() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tglLahirSaksi2C.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }

  ///TANGGAL PERKAWINAN
  void tglPencatatanPerkawinan() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tglPencatatanPerkawinanC.text =
            DateFormat('yyyy-MM-dd').format(selectedDate);
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

  ///JENIS KALENDER
  // void date() async {
  //   await showDatePicker(
  //     context: Get.context!,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime.now(),
  //   ).then((selectedDate) {
  //     if (selectedDate != null) {
  //       dateC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
  //     }
  //   });
  // }

  ///UNTUK MENAMPILKAN DI TEXT BIASA
  // void chooseDate() async {
  //   DateTime? picketDate = await showDatePicker(
  //     context: Get.context!,
  //     initialDate: selectedDate.value,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2023),
  //   );
  //   if (picketDate != null && picketDate != selectedDate.value) {
  //     selectedDate.value = picketDate;
  //   }
  // }
}
