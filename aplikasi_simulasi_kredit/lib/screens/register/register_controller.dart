import 'package:aplikasi_simulasi_kredit/widgets/get_snackbar.dart';
import 'package:aplikasi_simulasi_kredit/widgets/login_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final firestore = FirebaseFirestore.instance;

  registerUser(BuildContext context, Map<String, dynamic> data) async {
    Loader.show(context);

    final isUsernameExist = await _checkIsUsernameExist(data['username']);
    if (isUsernameExist != null) {
      if (isUsernameExist) {
        Loader.close(context);
        GetSnackbar.show('Error', 'Username telah digunakan!', false);
      } else {
        _doRegister(context, data);
      }
    }
  }

  Future<bool?> _checkIsUsernameExist(String username) async {
    bool result = false;

    final userRef = firestore.collection("users");
    await userRef.where('username', isEqualTo: username).get().then((value) {
      if (value.docs.isNotEmpty) {
        result = true;
      }
    }).catchError((error) {
      GetSnackbar.show('Error', error.message.toString(), false);
      return null;
    });

    return result;
  }

  _doRegister(BuildContext context, Map<String, dynamic> data) async {
    final userRef = firestore.collection("users");
    await userRef.add(data).then((value) {
      Loader.close(context);
      Get.back();
      GetSnackbar.show('Sukses', 'Silahkan login!', true);
    }).catchError((error) {
      Loader.close(context);
      GetSnackbar.show('Error', error.message.toString(), false);
    });
  }
}
