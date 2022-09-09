import 'package:aplikasi_simulasi_kredit_admin/screens/home/home_screen.dart';
import 'package:aplikasi_simulasi_kredit_admin/widgets/get_snackbar.dart';
import 'package:aplikasi_simulasi_kredit_admin/widgets/login_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final firestore = FirebaseFirestore.instance;

  bool isLoggedIn() {
    final storage = GetStorage();
    final String? id = storage.read('userId');
    print('TAG, $id');
    return id != null;
  }

  login(BuildContext context, Map<String, dynamic> data) {
    Loader.show(context);

    firestore
        .collection('admins')
        .where('username', isEqualTo: data['username'])
        .where('password', isEqualTo: data['password'])
        .get()
        .then((value) async {
      Loader.close(context);

      if (value.docs.isEmpty) {
        GetSnackbar.show('Error', 'Invalid username / password!', false);
      } else {
        final storage = GetStorage();
        await storage.write('userId', value.docs.first.id);
        Get.offAll(() => const HomeScreen());
      }
    }).catchError((error) {
      Loader.close(context);
      GetSnackbar.show('Error', error.message.toString(), false);
    });
  }
}
