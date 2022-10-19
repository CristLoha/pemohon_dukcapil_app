import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference ktp = FirebaseFirestore.instance.collection('ktp');

  Stream<QuerySnapshot<Object?>> streamKTP() {
    return ktp.orderBy('createdAt', descending: true).snapshots();
  }
}
