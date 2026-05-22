import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/services/session_service.dart';

class AuthController extends GetxController {
  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isPasswordHidden = true.obs;

  Future<void> login() async {
    try {
      isLoading.value = true;

      if (usernameController.text.isEmpty ||
          passwordController.text.isEmpty) {
        Get.snackbar('Error', 'Username dan password wajib diisi');
        return;
      }

      await SessionService.saveLogin(
        usernameController.text,
        passwordController.text,
      );

      Get.offAllNamed(AppRoutes.home);
    } finally {
      isLoading.value = false;
    }
  }
}