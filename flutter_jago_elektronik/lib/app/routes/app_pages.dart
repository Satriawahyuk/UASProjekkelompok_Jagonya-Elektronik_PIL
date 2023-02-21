import 'package:get/get.dart';
import 'package:flutter_jago_elektronik/app/modules/home/views/home_view.dart';
import 'package:flutter_jago_elektronik/app/modules/auth/views/auth_view.dart';
import 'package:flutter_jago_elektronik/app/modules/splash/views/splash_view.dart';
import 'package:flutter_jago_elektronik/app/modules/product/views/product_view.dart';
import 'package:flutter_jago_elektronik/app/modules/product/views/detail_product_view.dart';
import 'package:flutter_jago_elektronik/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_jago_elektronik/app/modules/product/bindings/product_binding.dart';
import 'package:flutter_jago_elektronik/app/modules/product/bindings/detail_product_binding.dart';
import 'package:flutter_jago_elektronik/app/modules/auth/bindings/auth_bindings.dart';
import 'package:flutter_jago_elektronik/app/modules/splash/bindings/splash_binding.dart';
import 'package:flutter_jago_elektronik/app/modules/admin/views/add_category_view.dart';
import 'package:flutter_jago_elektronik/app/modules/admin/views/add_partner_view.dart';
import 'package:flutter_jago_elektronik/app/modules/admin/views/add_banner_view.dart';
import 'package:flutter_jago_elektronik/app/modules/admin/views/add_product_view.dart';
import 'package:flutter_jago_elektronik/app/modules/admin/bindings/add_category_binding.dart';
import 'package:flutter_jago_elektronik/app/modules/admin/bindings/add_partner_binding.dart';
import 'package:flutter_jago_elektronik/app/modules/admin/bindings/add_banner_binding.dart';
import 'package:flutter_jago_elektronik/app/modules/admin/bindings/add_product_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.auth,
      page: () => const AuthView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.product,
      page: () => const ProductView(),
      binding: ProductBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.detailProduct,
      page: () => const DetailProductView(),
      binding: DetailProductBinding(),
      transition: Transition.rightToLeftWithFade,
    ),

    // =============
    // Admin Page
    // =============
    GetPage(
      name: _Paths.addCategory,
      page: () => const AddCategoryView(),
      binding: AddCategoryBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.addPartner,
      page: () => const AddPartnerView(),
      binding: AddPartnerBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.addBanner,
      page: () => const AddBannerView(),
      binding: AddBannerBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: _Paths.addProduct,
      page: () => const AddProductView(),
      binding: AddProductBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
