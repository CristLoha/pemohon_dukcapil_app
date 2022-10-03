import 'package:get/get.dart';

class MainPageController extends GetxController {
  Rx<ButtonIcons> selected = ButtonIcons.home.obs;

  homeButton() {
    selected.value = ButtonIcons.home;
  }

  historyButton() {
    selected.value = ButtonIcons.history;
  }

  chatButton() {
    selected.value = ButtonIcons.profile;
  }

  settingsButton() {
    selected.value = ButtonIcons.settings;
  }
}

enum ButtonIcons {
  home,
  history,
  profile,
  settings,
}
