import 'package:flutter_jago_elektronik/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_jago_elektronik/app/utils/widget/widgets.dart';
import 'package:flutter_jago_elektronik/app/utils/style/app_colors.dart';
import 'package:flutter_jago_elektronik/app/data/model/product_data.dart';
import 'package:flutter_jago_elektronik/app/modules/product/controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: TextFormat(
          (controller.category == null)
              ? "Jagonya Elektronik"
              : controller.category!.name,
          34.sp,
          fontColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.backgroundColor,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 24.h,
          ),
          constraints: BoxConstraints(minHeight: 1.sh),
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              InputField(
                controller.queryInput,
                hint: "Cari semua elektronik",
                suffixIcon: const Icon(Icons.search),
                onSubmit: (query) => controller.searchProduct(),
              ),
              SizedBox(height: 24.h),
              Obx(() {
                if (controller.finishGetProducts.value) {
                  return productsWidget();
                } else {
                  return Center(
                    child: SizedBox(
                      height: 0.2.sw,
                      width: 0.2.sw,
                      child: const CircularProgressIndicator(),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget productsWidget() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: controller.products.length,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return productWidget(controller.products[index]);
      },
    );
  }

  Widget productWidget(ProductData product) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.detailProduct,
          arguments: {"data": product},
        );
      },
      onLongPress: () {
        if (controller.authFirebase.data != null) {
          if (controller.authFirebase.data!.isAdmin) {
            Get.toNamed(
              Routes.addProduct,
              arguments: {"data": product},
            );
          }
        }
      },
      child: Card(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OnlineImage(
                imageUrl: product.photo,
                height: 0.3.sw,
                width: 0.3.sw,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 12.h),
              TextFormat(
                product.name,
                32.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
