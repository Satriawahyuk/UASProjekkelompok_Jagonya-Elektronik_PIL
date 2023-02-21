import 'package:flutter_jago_elektronik/app/data/auth.dart';
import 'package:flutter_jago_elektronik/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final authFirebase = Get.find<AuthFirebase>();

  SplashController() {
    init();
  }

  void init() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (authFirebase.currentUser != null) {
          Get.offAllNamed(Routes.home);
        } else {
          Get.offAllNamed(Routes.auth);
        }
      },
    );
  }
}
