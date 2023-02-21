import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jago_elektronik/app/utils/key.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_jago_elektronik/app/utils/helper.dart';
import 'package:flutter_jago_elektronik/app/utils/widget/widgets.dart';
import 'package:flutter_jago_elektronik/app/utils/style/app_colors.dart';
import 'package:flutter_jago_elektronik/app/modules/admin/controllers/add_category_controller.dart';

class AddCategoryView extends GetView<AddCategoryController> {
  const AddCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: TextFormat(
          "${(controller.sData == null) ? "Tambah" : "Perbarui"} Kategori",
          34.sp,
          fontColor: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 24.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                inputPhotoWidget(),
                SizedBox(height: 24.h),
                InputField(
                  controller.nameInput,
                  hint: "Nama kategori",
                ),
              ],
            ),
            Column(
              children: [
                ActionButton(
                  text: (controller.sData == null) ? "Tambahkan" : "Perbarui",
                  fontSize: 32.sp,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.w600,
                  boxColor: AppColors.greenColor,
                  minimumSize: Size(0.9.sw, 80.h),
                  onTap: () {
                    if (controller.sData != null) {
                      controller.editCategory();
                    } else {
                      if (controller.checkInput()) {
                        controller.addCategory();
                      }
                    }
                  },
                ),
                SizedBox(height: 24.h),
                if (controller.sData != null)
                  ActionButton(
                    text: "Hapus",
                    fontSize: 32.sp,
                    fontColor: Colors.white,
                    fontWeight: FontWeight.w600,
                    boxColor: AppColors.alertColor,
                    minimumSize: Size(0.9.sw, 80.h),
                    onTap: () => controller.deleteCategory(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget inputPhotoWidget() {
    return GestureDetector(
      onTap: () {
        getImage().then(
          (value) {
            if (value != null) {
              controller.file = value;
              controller.update([GetBuilderKeys.imageWidgetKey]);
            }
          },
        );
      },
      child: Container(
        width: 1.sw,
        height: 0.25.sh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.subtitleColorText,
            width: 2,
          ),
        ),
        child: GetBuilder<AddCategoryController>(
          id: GetBuilderKeys.imageWidgetKey,
          builder: (controller) {
            if (controller.file == null) {
              if (controller.sData != null) {
                return OnlineImage(
                  imageUrl: controller.sData!.photo,
                  width: 1.sw,
                  height: 0.25.sh,
                  fit: BoxFit.fitWidth,
                );
              }
              return Icon(
                Icons.add_a_photo,
                size: 0.15.sw,
                color: AppColors.subtitleColorText,
              );
            }
            return Image.file(
              fit: BoxFit.fitWidth,
              File(controller.file!.path),
            );
          },
        ),
      ),
    );
  }
}
