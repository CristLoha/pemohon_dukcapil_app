import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/utils/error_screen.dart';
import 'app/utils/splash_screen.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth auth = FirebaseAuth.instance;

  await initializeDateFormatting('id_ID', null).then(
    (_) => runApp(
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
                  snapshot.data != null && snapshot.data!.emailVerified == true
                      ? Routes.LANDING_SCREEN
                      : Routes.LOGIN,
              getPages: AppPages.routes,
              builder: EasyLoading.init(),
            );
          }),
    ),
  );
}
