import 'package:aplikasi_simulasi_kredit_admin/models/user.dart';
import 'package:aplikasi_simulasi_kredit_admin/widgets/get_snackbar.dart';
import 'package:aplikasi_simulasi_kredit_admin/widgets/login_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final user = UserModel(
          address: '',
          birth: '',
          company: '',
          name: '',
          nik: '',
          password: '',
          phone: '',
          username: '')
      .obs;

  BuildContext context;
  String userId;

  DetailController({required this.context, required this.userId});

  _getUserDetail(BuildContext context, String id) {
    Loader.show(context);

    final firestore = FirebaseFirestore.instance;
    final userRef = firestore.collection("users");

    userRef.doc(id).get().then((value) {
      Loader.close(context);

      final data = value.data();
      user.value = UserModel.fromJson(data!);
    }).catchError((error) {
      Loader.close(context);
      GetSnackbar.show('Error', error.message.toString(), false);
    });
  }

  @override
  void onInit() {
    Future.delayed(Duration.zero, () {
      _getUserDetail(context, userId);
    });
    super.onInit();
  }
}
