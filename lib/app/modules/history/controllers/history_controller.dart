import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? userPemohon = FirebaseAuth.instance.currentUser;

  CollectionReference ktp = FirebaseFirestore.instance.collection('ktp');

  // Stream<QuerySnapshot<Object?>> streamKTP() {
  //   return ktp.orderBy('createdAt', descending: true).snapshots();
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamKTP() async* {
    yield* firestore
        .collection('ktp')
        .where('email', isEqualTo: userPemohon!.email)
        .snapshots();
  }
}
