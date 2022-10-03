import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    ScreenUtilInit(
      designSize: const Size(360, 720),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: Routes.LOGIN,
          getPages: AppPages.routes,
        );
      },
    ),
  );

  //   DevicePreview(
  //       builder: (context) => GetMaterialApp(
  //             debugShowCheckedModeBanner: false,
  //             title: "Application",
  //             initialRoute: Routes.LOGIN,
  //             getPages: AppPages.routes,
  //           )),
  // );
  //   FutureBuilder(
  //     future: initialization,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         return ErrorScreen();
  //       }
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         return FutureBuilder(
  //           future: Future.delayed(
  //             Duration(seconds: 3),
  //           ),
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.done) {
  //               return GetMaterialApp(
  //                 debugShowCheckedModeBanner: false,
  //                 title: "Application",
  //                 initialRoute: Routes.LOGIN,
  //                 getPages: AppPages.routes,
  //               );
  //             }
  //             return SplashhScreen();
  //           },
  //         );
  //       }
  //       return LoadingScreen();
  //     },
  //   ),
  // );
}
