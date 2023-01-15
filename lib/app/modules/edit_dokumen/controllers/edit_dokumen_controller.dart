import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart' as s;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditDokumenController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  RxBool profile = false.obs;

  XFile? pickedImageKtp;
  final ImagePicker imagePicker = ImagePicker();
  s.FirebaseStorage storage = s.FirebaseStorage.instance;

  ///TEXT EDITING

  TextEditingController nikC = TextEditingController();
  TextEditingController namaC = TextEditingController();
  TextEditingController noTeleponC = TextEditingController();
  TextEditingController tanggalC = TextEditingController();
  TextEditingController provinsiC = TextEditingController();
  TextEditingController kabupatenC = TextEditingController();
  TextEditingController kecamatanC = TextEditingController();
  TextEditingController desaC = TextEditingController();
  TextEditingController keteranganC = TextEditingController();

  Future<DocumentSnapshot<Object?>> getData(String docId) async {
    DocumentReference documentReference =
        firestore.collection('layanan').doc(docId);
    return documentReference.get();
  }

  void editPerekamanKtp(
    String nama,
    String keterangan,
    String kabupaten,
    String kecamatan,
    String provinsi,
    String docId,
  ) async {
    Random random = Random();
    int randomNumber = random.nextInt(100000) + 1;
    DocumentReference documentReference =
        firestore.collection('layanan').doc(docId);
    try {
      await documentReference.update({
        'nama': nama,
        'kecamatan': kecamatan,
        'provinsi': provinsi,
        'keterangan': keterangan,
        'proses': 'PROSES VERIFIKASI',
        'updatedTime': DateTime.now().toIso8601String(),
      });
      String ext = pickedImageKtp!.name.split(".").last;
      await storage.ref('perekamanKTP').child('KK$randomNumber.$ext').putFile(
            File(pickedImageKtp!.path),
          );

      String fotoKK = await storage
          .ref('perekamanKTP')
          .child('KK$randomNumber.$ext')
          .getDownloadURL();

      await firestore
          .collection("layanan")
          .doc(docId)
          .update({"fotoKK": fotoKK});

      // EasyLoading.dismiss();
      // EasyLoading.showSuccess('Berhasil Terkirim');

    } catch (e) {
      print('kaka');
    }
  }

  void selectImage() async {
    try {
      final dataImage = await imagePicker.pickImage(
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
          pickedImageKtp = dataImage;
        }
      }
      update();
    } catch (err) {
      print(err);
      pickedImageKtp = null;
      update();
    }
  }

  void resetImage() {
    pickedImageKtp = null;
    update();
  }

  ///UNTUK FORM
  void dateLocal() async {
    await DatePicker.showDatePicker(
      Get.context!,
      locale: LocaleType.id,
      minTime: DateTime(1970, 1, 1),
      maxTime: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        tanggalC.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
  }
}
