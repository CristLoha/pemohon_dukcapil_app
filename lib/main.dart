import 'package:flutter/material.dart';

import 'app/utils/error_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  await GetStorage.init();
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
