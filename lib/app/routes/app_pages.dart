import 'package:get/get.dart';

import 'package:pemohon_dukcapil_app/app/modules/home/bindings/home_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/home/views/home_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/landing_screen/bindings/landing_screen_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/landing_screen/views/landing_screen_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/login/bindings/login_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/login/views/login_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/main_page/bindings/main_page_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/main_page/views/main_page_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/register/bindings/register_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LANDING_SCREEN,
      page: () => LandingScreenView(),
      binding: LandingScreenBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_PAGE,
      page: () => MainPageView(),
      binding: MainPageBinding(),
    ),
  ];
}
