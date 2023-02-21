import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_jago_elektronik/app/data/banner.dart';
import 'package:flutter_jago_elektronik/app/utils/dialog.dart';
import 'package:flutter_jago_elektronik/app/routes/app_pages.dart';
import 'package:flutter_jago_elektronik/app/data/model/simple_data.dart';

class AddBannerController extends GetxController {
  final bannerFirestore = Get.find<BannerFirestore>();
  SimpleData? sData = Get.arguments['data'] as SimpleData?;

  final nameInput = TextEditingController();
  XFile? file;

  AddBannerController() {
    if (sData != null) {
      nameInput.text = sData!.name;
    }
  }

  bool checkInput() {
    if (file == null) {
      openErrorDialog("Photo cannot empty");
      return false;
    }
    if (nameInput.text.isEmpty) {
      openErrorDialog("Name cannot empty");
      return false;
    }

    return true;
  }

  void addBanner() {
    openLoadingDialog();
    bannerFirestore
        .addBanner(
      name: nameInput.text,
      photo: File(file!.path),
    )
        .whenComplete(() {
      Get.back();
      Get.offAllNamed(Routes.home);
    });
  }

  void editBanner() {
    openLoadingDialog();
    bannerFirestore
        .editBanner(
            id: sData!.id,
            name: nameInput.text,
            photo: (file == null) ? null : File(file!.path))
        .whenComplete(() {
      Get.back();
      Get.offAllNamed(Routes.home);
    });
  }

  void deleteBanner() {
    openLoadingDialog();
    bannerFirestore.deleteBanner(id: sData!.id).whenComplete(() {
      Get.back();
      Get.offAllNamed(Routes.home);
    });
  }
}
