import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
  final ImagePicker imagePicker = ImagePicker();

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
  TextEditingController tglLahirPemohonC = TextEditingController();
  TextEditingController jenisKelaminPemohonC = TextEditingController();
  TextEditingController pekerjaanPemohonC = TextEditingController();
  TextEditingController desaPemohonC = TextEditingController();
  TextEditingController kecamatanPemohonC = TextEditingController();
  TextEditingController kabupatenPemohonC = TextEditingController();
  TextEditingController provinsiPemohonC = TextEditingController();
  TextEditingController kewarganegaraanPemohonC = TextEditingController();

  TextEditingController nikC = TextEditingController();

  TextEditingController keteranganC = TextEditingController();

  int index = 0;
  List<GlobalKey<FormState>> formKeys = [
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

  XFile? pickedImage;
  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore2 = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? userPemohon = FirebaseAuth.instance.currentUser;

  void addrekamanKTP() async {
    String uid = auth.currentUser!.uid;
    Random random = Random();
    int randomNumber = random.nextInt(100000) + 1;
    if (pickedImage != null) {
      String ext = pickedImage!.name.split(".").last;
      await storage.ref('perekamanKTP').child('KK$randomNumber.$ext').putFile(
            File(pickedImage!.path),
          );

      String fotoKK = await storage
          .ref('perekamanKTP')
          .child('KK$randomNumber.$ext')
          .getDownloadURL();

      CollectionReference rekamanKtp = firestore.collection('layanan');

      await rekamanKtp.add({
        ///BAYI/ANAK
        "namaAnak": nameAnakC.text,
        "keyName": nameAnakC.text.substring(0, 1).toUpperCase(),
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
        "kecamatanPemohon": desaPemohonC.text,
        "kabupatenPemohon": kabupatenPemohonC.text,
        "provinsiPemohon": provinsiPemohonC.text,
        "kewarganegaraanPemohon": provinsiPemohonC.text,

        ///PROSES
        'kategori': 'Akta Kelahiran',
        'uid': uid,
        'keterangan': keteranganC.text,
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
      EasyLoading.showError('Data tidak boleh kosong');
      print('data tidak boleh kosong');
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

  void resetImage() {
    pickedImage = null;
    update();
  }

  void selectImage() async {
    try {
      final dataImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImage = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImage = null;
      update();
    }
  }

  void uploadImage() async {
    s.Reference storageRef = storage.ref("rekamanKTP/kk.jpg");
    File file = File(pickedImage!.path);
    try {
      final dataUpload = await storageRef.putFile(file);
      print(dataUpload);
    } catch (e) {
      print('err');
    }
  }

  ///tgl lahir anak
  void tglLahirAnak() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tglLahirAnakC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }

  ///tgl lahir ibu
  void tglLahirIbu() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tanggalLahirIbuC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }

  ///tgl lahir ayah
  void tglLahirAah() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1960, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tanggalLahirAyahC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
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
