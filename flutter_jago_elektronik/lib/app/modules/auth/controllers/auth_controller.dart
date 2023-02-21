import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jago_elektronik/app/data/auth.dart';
import 'package:flutter_jago_elektronik/app/utils/dialog.dart';
import 'package:flutter_jago_elektronik/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final frontNameInput = TextEditingController();
  final endNameInput = TextEditingController();
  final emailInput = TextEditingController();
  final passwordInput = TextEditingController();
  final confirmPasswordInput = TextEditingController();
  final authFirebase = Get.find<AuthFirebase>();

  // Reactive variable
  RxInt pageNumber = 0.obs;

  void signInUser() {
    authFirebase.signIn(
      email: emailInput.text,
      password: passwordInput.text,
    ).then((value) {
      Get.back();
      if (value != null) {
        openErrorDialog(value);
      } else {
        openSuccessDialog("Login Success");
        Get.offAllNamed(Routes.home);
      }
    });
  }

  bool checkSignInInput() {
    if (emailInput.text.isEmpty) {
      openErrorDialog("Email tidak boleh kosong");
      return false;
    }
    if (passwordInput.text.isEmpty) {
      openErrorDialog("Password tidak boleh kosong");
      return false;
    }
    return true;
  }

  void signUpUser() {
    authFirebase
        .signUp(
      email: emailInput.text,
      password: passwordInput.text,
      frontName: frontNameInput.text,
      endName: endNameInput.text,
    ).then((value) {
      Get.back();
      if (value != null) {
        openErrorDialog(value);
      } else {
        openSuccessDialog("Register Success");
        Get.offAllNamed(Routes.home);
      }
    });
  }

  bool checkSignUpInput() {
    if (emailInput.text.isEmpty) {
      openErrorDialog("Email tidak boleh kosong");
      return false;
    }
    if (frontNameInput.text.isEmpty) {
      openErrorDialog("Nama depan tidak boleh kosong");
      return false;
    }
    if (passwordInput.text.isEmpty) {
      openErrorDialog("Password tidak boleh kosong");
      return false;
    }
    if (confirmPasswordInput.text.isEmpty) {
      openErrorDialog("Konfirmasi password tidak boleh kosong");
      return false;
    }

    if (confirmPasswordInput.text != passwordInput.text) {
      openErrorDialog("Konfirmasi password tidak sama");
      return false;
    }
    return true;
  }
}
