part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static get home => _Paths.home;
  static get auth => _Paths.auth;
  static get splash => _Paths.splash;
  static get product => _Paths.product;
  static get detailProduct => _Paths.detailProduct;

  // =============
  // Admin Page
  // =============
  static get addCategory => _Paths.addCategory;
  static get addProduct => _Paths.addProduct;
  static get addPartner => _Paths.addPartner;
  static get addBanner => _Paths.addBanner;
}

abstract class _Paths {
  _Paths._();
  static get home => '/home';
  static get auth => '/auth';
  static get splash => '/splash';
  static get product => '/product';
  static get detailProduct => '/detail-product';

  // =============
  // Admin Page
  // =============
  static get addCategory => '/add-category';
  static get addPartner => '/add-partner';
  static get addBanner => '/add-vanner';
  static get addProduct => '/add-product';

}
