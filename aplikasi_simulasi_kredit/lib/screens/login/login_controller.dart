import 'package:aplikasi_simulasi_kredit/screens/home/home_screen.dart';
import 'package:aplikasi_simulasi_kredit/widgets/get_snackbar.dart';
import 'package:aplikasi_simulasi_kredit/widgets/login_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final firestore = FirebaseFirestore.instance;

  bool isLoggedIn() {
    final storage = GetStorage();
    final String? id = storage.read('userId');

    return id != null;
  }

  login(BuildContext context, Map<String, dynamic> data) {
    Loader.show(context);

    firestore
        .collection('users')
        .where('username', isEqualTo: data['username'])
        .where('password', isEqualTo: data['password'])
        .get()
        .then((value) {
      final storage = GetStorage();
      storage.write('userId', value.docs.first.id);
      Loader.close(context);
      Get.offAll(() => const HomeScreen());
    }).catchError((error) {
      Loader.close(context);
      GetSnackbar.show('Error', error.message.toString(), false);
    });
  }
}
