import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_jago_elektronik/app/utils/key.dart';
import 'package:flutter_jago_elektronik/app/utils/dialog.dart';
import 'package:flutter_jago_elektronik/app/utils/widget/widgets.dart';
import 'package:flutter_jago_elektronik/app/utils/style/app_colors.dart';
import 'package:flutter_jago_elektronik/app/modules/auth/controllers/auth_controller.dart';

part 'login_component.dart';
part 'register_component.dart';
part 'onboard_component.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Color.fromARGB(120, 61, 61, 61),
              BlendMode.darken,
            ),
            child: Image.asset(
              '${Global.images}/background.webp',
              fit: BoxFit.fitHeight,
              height: 1.sh,
            ),
          ),
          Obx(() {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeInCirc,
              transitionBuilder: (child, animation) => SlideTransition(
                position: Tween(
                  begin: const Offset(1.0, 1.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation),
                child: child,
              ),
              child: pageSwitcher(controller.pageNumber.value),
            );
          }),
        ],
      ),
    );
  }

  Widget pageSwitcher(page) {
    switch (page) {
      case 0:
        return OnBoardComponent();
      case 1:
        return LoginComponent();
      case 2:
        return RegisterComponent();
      default:
        return OnBoardComponent();
    }
  }
}
