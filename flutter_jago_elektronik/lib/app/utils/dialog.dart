import 'package:flutter/material.dart';
import 'package:flutter_jago_elektronik/app/utils/style/app_colors.dart';
import 'package:flutter_jago_elektronik/app/utils/widget/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void openLoadingDialog() {
  Get.dialog(
    Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 48.h,
          horizontal: 32.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
            TextFormat("Loading..", 32.sp),
          ],
        ),
      ),
    ),
    useSafeArea: true,
  );
}

void openErrorDialog(String message) {
  Get.dialog(
    Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: 24.w,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 32.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.close,
              color: AppColors.alertColor,
              size: 146.h,
            ),
            TextFormat(
              message,
              32.sp,
              maxLines: 5,
            ),
          ],
        ),
      ),
    ),
    useSafeArea: true,
    barrierDismissible: true,
  );
}

void openSuccessDialog(String message) {
  Get.dialog(
    Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: 24.w,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 32.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.done,
              color: AppColors.greenColor,
              size: 146.h,
            ),
            TextFormat(
              message,
              32.sp,
              maxLines: 5,
            ),
          ],
        ),
      ),
    ),
    useSafeArea: true,
    barrierDismissible: true,
  );
}
