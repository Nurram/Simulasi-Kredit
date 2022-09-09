import 'package:aplikasi_simulasi_kredit/widgets/login_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../widgets/get_snackbar.dart';

class AddController extends GetxController {
  final firestore = FirebaseFirestore.instance;

  getInterest(BuildContext context, TextEditingController controller) {
    Loader.show(context);

    firestore.collection('interest').get().then((value) {
      Loader.close(context);

      final data = value.docs[0].data();
      controller.text = '${data['value']}%';
    }).catchError((error) {
      Loader.close(context);
      GetSnackbar.show('Error', error.message.toString(), false);
    });
  }
}
