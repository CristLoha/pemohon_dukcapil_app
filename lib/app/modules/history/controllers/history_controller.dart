import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  CollectionReference ktp = FirebaseFirestore.instance.collection('ktp');

  // Stream<QuerySnapshot<Object?>> streamKTP() {
  //   return ktp.orderBy('createdAt', descending: true).snapshots();
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamKTP() async* {
    String uid = auth.currentUser!.uid;
    yield* firestore
        .collection('pemohon')
        .doc(uid)
        .collection('ktp')
        .snapshots();
  }
}
