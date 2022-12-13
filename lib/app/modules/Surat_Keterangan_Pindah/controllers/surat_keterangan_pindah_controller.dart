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

class SuratKeteranganPindahController extends GetxController {
  RxInt currentStep = 0.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  XFile? pickedImageKK;
  final ImagePicker imagePickerKK = ImagePicker();
  XFile? pickedImageKTP;
  final ImagePicker imagePickerKTP = ImagePicker();

  ///PEMOHON
  TextEditingController nameC = TextEditingController();
  TextEditingController nikC = TextEditingController();
  TextEditingController noKKC = TextEditingController();
  TextEditingController provinsiTujuan = TextEditingController();
  TextEditingController kabupatenKotaTujuan = TextEditingController();
  TextEditingController kecamatanTujuan = TextEditingController();
  TextEditingController desaC = TextEditingController();
  TextEditingController alamatTujuan = TextEditingController();
  TextEditingController rtC = TextEditingController();
  TextEditingController rwC = TextEditingController();
  TextEditingController statusNoKK = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController noTelpC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();

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

  List<Map<String, dynamic>> statusNoKKbagiyangPindah = [
    {
      "statusKK": "KK Baru",
      "id": 1,
    },
    {
      "statusKK": "Numpang KK",
      "id": 2,
    },
    {
      "statusKK": "Nomor KK Tetap",
      "id": 2,
    }
  ];

  s.FirebaseStorage storage = s.FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore2 = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? userPemohon = FirebaseAuth.instance.currentUser;

  void addrekamanKTP() async {
    String uid = auth.currentUser!.uid;
    Random random = Random();
    int randomNumber = random.nextInt(100000) + 1;
    if (pickedImageKK != null && pickedImageKTP != null) {
      ///KK
      String extKK = pickedImageKK!.name.split(".").last;
      await storage.ref('SUKET Pindah').child('KK$randomNumber.$extKK').putFile(
            File(pickedImageKK!.path),
          );

      String fotoKK = await storage
          .ref('SUKET Pindah')
          .child('KK$randomNumber.$extKK')
          .getDownloadURL();

      ///SUKET PINDAH
      String extKTP = pickedImageKTP!.name.split(".").last;
      await storage
          .ref('SUKET Pindah')
          .child('KTP$randomNumber.$extKTP')
          .putFile(
            File(pickedImageKTP!.path),
          );

      String fotoKTP = await storage
          .ref('SUKET Pindah')
          .child('KTP$randomNumber.$extKTP')
          .getDownloadURL();

      CollectionReference rekamanKtp = firestore.collection('layanan');

      await rekamanKtp.add({
        /// PEMOHON
        'nama': nameC.text,
        'nik': nikC.text,
        'noKK': noKKC.text,
        'keyName': nameC.text.substring(0, 1).toUpperCase(),
        'provinsiTujuan': provinsiTujuan.text,
        'kabupatenTujuan': kabupatenKotaTujuan.text,
        'kecamatanTujuan': kecamatanTujuan.text,
        'desaTujuan': desaC.text,
        'alamatTujuan': alamatTujuan.text,
        'rt': rtC.text,
        'rw': rtC.text,
        'statusNoKK': statusNoKK.text,
        'email': userPemohon!.email,
        'noTelpon': noTelpC.text,

        ///Angota Keluarga   ///Nama Anggota
        'namaAnggota1': namaAnggota1.text,
        'namaAnggota2': namaAnggota2.text,
        'namaAnggota3': namaAnggota3.text,
        'namaAnggota4': namaAnggota4.text,
        'namaAnggota5': namaAnggota5.text,
        'namaAnggota6': namaAnggota6.text,

        ///PERSYARATAN
        'fotoKK': fotoKK,
        'fotoKTP': fotoKTP,

        ///PROSES
        'uid': uid,
        'kategori': 'Permohonan Pindah Datang',
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

  ///KK
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

  ///KTP
  void selectImageKTP() async {
    try {
      final dataImage = await imagePickerKTP.pickImage(
        source: ImageSource.gallery,
      );

      if (dataImage != null) {
        print(dataImage.name);
        print(dataImage.path);
        pickedImageKTP = dataImage;
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKTP = null;
      update();
    }
  }

  void resetImageKTP() {
    pickedImageKTP = null;
    update();
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
