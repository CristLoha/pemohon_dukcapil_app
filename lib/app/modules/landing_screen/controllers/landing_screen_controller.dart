import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/routes/app_pages.dart';

class LandingScreenController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? userPemohon = FirebaseAuth.instance.currentUser;
  RxBool isLoading = false.obs;

  final CollectionReference collectionPemohon =
      FirebaseFirestore.instance.collection('pemohon');
  void signOut() {
    auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
