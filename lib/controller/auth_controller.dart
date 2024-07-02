import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../pages/chat_page.dart';
import '../services/auth.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  Future<void> signIn(TextEditingController emailController,
      TextEditingController passwordController) async {
    isLoading.value = true;
    try {
      await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.offAll(const ChatPage());
    } on AuthException catch (error) {
      // Handling authentication errors
      Get.snackbar('Error', error.message);
    } catch (_) {
      // Handling unexpected errors
      Get.snackbar('Error', 'An unexpected error occurred');
    }
    isLoading.value = false;
  }
}
