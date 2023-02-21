import 'package:get/get.dart';
import '../controllers/add_partner_controller.dart';

class AddPartnerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AddPartnerController(),
    );
  }
}
