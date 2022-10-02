import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemohon_dukcapil_app/app/utils/error_screen.dart';
import 'package:pemohon_dukcapil_app/app/utils/loading_screen.dart';
import 'package:pemohon_dukcapil_app/app/utils/splash_screen.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<FirebaseApp> initialization = Firebase.initializeApp();

  runApp(
    //   DevicePreview(
    //       builder: (context) => GetMaterialApp(
    //             debugShowCheckedModeBanner: false,
    //             title: "Application",
    //             initialRoute: Routes.LOGIN,
    //             getPages: AppPages.routes,
    //           )),
    // );
    FutureBuilder(
      future: initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorScreen();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return FutureBuilder(
            future: Future.delayed(
              Duration(seconds: 3),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "Application",
                  initialRoute: Routes.LOGIN,
                  getPages: AppPages.routes,
                );
              }
              return SplashhScreen();
            },
          );
        }
        return LoadingScreen();
      },
    ),
  );
}
