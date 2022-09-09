import 'package:aplikasi_simulasi_kredit_admin/models/user.dart';
import 'package:aplikasi_simulasi_kredit_admin/widgets/get_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../widgets/login_dialog.dart';

class AccountController extends GetxController {
  final BuildContext context;
  final userData = <UserModel>[].obs;

  AccountController({required this.context});

  @override
  void onInit() {
    Future.delayed(Duration.zero, () {
      _getUserData(context);
    });

    super.onInit();
  }

  _getUserData(BuildContext context) {
    Loader.show(context);

    final storage = GetStorage();
    final String? id = storage.read('userId');
    final firestore = FirebaseFirestore.instance;

    firestore.collection('admins').doc(id).get().then((value) {
      Loader.close(context);

      final data = value.data();
      final userModel = UserModel.fromJson(data!);

      userData.clear();
      userData.add(userModel);
    }).catchError((error) {
      Loader.close(context);
      GetSnackbar.show('Error', error.toString(), false);
    });
  }
}
