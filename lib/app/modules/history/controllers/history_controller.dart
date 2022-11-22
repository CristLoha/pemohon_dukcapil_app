import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? userPemohon = FirebaseAuth.instance.currentUser;

  // Stream<QuerySnapshot<Object?>> streamKTP() {
  //   return ktp.orderBy('createdAt', descending: true).snapshots();
  // }
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Perekaman E-KTP'),
    Tab(text: 'Perubahan E-KTP'),
  ];

  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    tabController?.dispose();

    super.onClose();
  }

  Stream<QuerySnapshot<Object?>> getLayanan() {
    CollectionReference layanan = firestore.collection('layanan');
    return layanan
        .where('email', isEqualTo: userPemohon!.email)
        .orderBy('updatedTime', descending: true)
        .snapshots();
  }
}
