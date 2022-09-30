import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashhScreen extends StatelessWidget {
  const SplashhScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/logo.png',
                  height: 100,
                ),
                Container(
                  width: 80,
                  child: Lottie.asset('assets/lottie/loading.json'),
                )
              ],
            ),
          ),
        ));
  }
}
