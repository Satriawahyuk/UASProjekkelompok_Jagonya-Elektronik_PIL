import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_jago_elektronik/app/utils/key.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_jago_elektronik/app/utils/helper.dart';
import 'package:flutter_jago_elektronik/app/routes/app_pages.dart';
import 'package:flutter_jago_elektronik/app/utils/widget/widgets.dart';
import 'package:flutter_jago_elektronik/app/utils/style/app_colors.dart';
import 'package:flutter_jago_elektronik/app/data/model/product_data.dart';
import 'package:flutter_jago_elektronik/app/modules/home/controllers/home_controller.dart';

// Child pages
part 'home_component.dart';
part 'save_component.dart';
part 'profile_component.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Obx(() {
          return TextFormat(
            getTitle(controller.index.value),
            34.sp,
            fontColor: Colors.white,
          );
        }),
        actions: [
          GetBuilder<HomeController>(
            id: GetBuilderKeys.authStateKey,
            builder: (controller) {
              if (controller.authFirebase.data != null) {
                if (controller.authFirebase.data!.isAdmin) {
                  return IconButton(
                    onPressed: () {
                      Get.toNamed(Routes.addProduct, arguments: {});
                    },
                    icon: const Icon(Icons.format_list_bulleted_add),
                  );
                }
              }

              return const SizedBox();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          return PageTransitionSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation, secondaryAnimation) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
            child: getPage(controller.index.value),
          );
        }),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Obx(() {
          return BottomNavigationBar(
            currentIndex: controller.index.value,
            selectedLabelStyle: TextStyle(fontSize: 0.sp),
            onTap: (index) {
              controller.index.value = index;
            },
            selectedIconTheme: IconThemeData(
              size: 54.r,
              color: AppColors.primaryColor,
            ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: "",
              ),
            ],
          );
        }),
      ),
    );
  }

  String getTitle(int index) {
    switch (index) {
      case 0:
        return "Jagonya Elektronik";
      case 1:
        return "Tersimpan";
      case 2:
        return "Profile";
      default:
        return "Jagonya Elektronik";
    }
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return HomeComponent();
      case 1:
        return SaveComponent();
      case 2:
        return ProfileComponent();
      default:
        return HomeComponent();
    }
  }
}
