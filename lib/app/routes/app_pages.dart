import 'package:get/get.dart';

import 'package:pemohon_dukcapil_app/app/modules/detailRiwayat/bindings/detail_riwayat_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/detailRiwayat/views/detail_riwayat_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/history/bindings/history_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/history/views/history_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/home/bindings/home_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/home/views/home_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/kartu_keluarga/bindings/kartu_keluarga_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/kartu_keluarga/views/kartu_keluarga_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/landing_screen/bindings/landing_screen_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/landing_screen/views/landing_screen_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/login/bindings/login_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/login/views/login_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/main_page/bindings/main_page_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/main_page/views/main_page_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/perubahan_ktp/bindings/perubahan_ktp_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/perubahan_ktp/views/perubahan_ktp_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/profile/views/profile_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/regis_akta_kematian/bindings/regis_akta_kematian_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/regis_akta_kematian/views/regis_akta_kematian_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/regist_kia/bindings/regist_kia_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/regist_kia/views/regist_kia_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/register/bindings/register_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/register/views/register_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/rekamananKtp/bindings/rekamanan_ktp_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/rekamananKtp/views/rekamanan_ktp_view.dart';
import 'package:pemohon_dukcapil_app/app/modules/settings/bindings/settings_binding.dart';
import 'package:pemohon_dukcapil_app/app/modules/settings/views/settings_view.dart';

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
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.REKAMANAN_KTP,
      page: () => RekamananKtpView(),
      binding: RekamananKtpBinding(),
    ),
    GetPage(
      name: _Paths.PERUBAHAN_KTP,
      page: () => PerubahanKtpView(),
      binding: PerubahanKtpBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_RIWAYAT,
      page: () => DetailRiwayatView(),
      binding: DetailRiwayatBinding(),
    ),
    GetPage(
      name: _Paths.REGIS_AKTA_KEMATIAN,
      page: () => RegisAktaKematianView(),
      binding: RegisAktaKematianBinding(),
    ),
    GetPage(
      name: _Paths.REGIST_KIA,
      page: () => RegistKiaView(),
      binding: RegistKiaBinding(),
    ),
    GetPage(
      name: _Paths.KARTU_KELUARGA,
      page: () => KartuKeluargaView(),
      binding: KartuKeluargaBinding(),
    ),
  ];
}
