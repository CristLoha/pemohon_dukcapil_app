import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailRiwayatController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController namaC = TextEditingController();
  TextEditingController desaC = TextEditingController();

  User? userPemohon = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Object?>> getData(String docId) async {
    DocumentReference documentReference =
        firestore.collection('layanan').doc(docId);
    return documentReference.get();
  }
}
