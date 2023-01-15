import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditDokumenController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController kabupatenC = TextEditingController();
  TextEditingController kabupatenPerC = TextEditingController();

  Future<DocumentSnapshot<Object?>> getData(String docId) async {
    DocumentReference documentReference =
        firestore.collection('layanan').doc(docId);
    return documentReference.get();
  }

  void editKeteranganKonfirmasi(
    String keterangan,
    String kabupaten,
    String kecamatan,
    String provinsi,
    String docId,
  ) async {
    DocumentReference documentReference =
        firestore.collection('layanan').doc(docId);
    try {
      await documentReference.update({
        'kabupaten': kabupaten,
        'provinsi': provinsi,
        'keterangan': keterangan,
      });
      // EasyLoading.dismiss();
      // EasyLoading.showSuccess('Berhasil Terkirim');
      Get.back();
    } catch (e) {
      print('kaka');
    }
  }
}
