import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/utils/error_screen.dart';
import 'app/utils/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth auth = FirebaseAuth.instance;

  runApp(
    //   DevicePreview(
    //       builder: (context) => GetMaterialApp(
    //             debugShowCheckedModeBanner: false,
    //             title: "Application",
    //             initialRoute: Routes.LOGIN,
    //             getPages: AppPages.routes,
    //           )),
    // );
    StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorScreen();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashhScreen();
          }

          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Application",
            initialRoute:
                snapshot.data != null ? Routes.MAIN_PAGE : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        }),
  );
}
