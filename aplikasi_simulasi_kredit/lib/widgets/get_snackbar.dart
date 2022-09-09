import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetSnackbar {
  static show(String title, String msg, bool success) {
    Get.snackbar(
      title,
      msg,
      colorText: Colors.white,
      backgroundColor: success ? Colors.green : Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 0,
      margin: EdgeInsets.zero,
    );
  }
}
