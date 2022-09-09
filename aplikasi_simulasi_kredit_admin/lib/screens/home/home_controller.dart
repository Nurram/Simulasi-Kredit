import 'package:aplikasi_simulasi_kredit_admin/models/kredit.dart';
import 'package:aplikasi_simulasi_kredit_admin/widgets/get_snackbar.dart';
import 'package:aplikasi_simulasi_kredit_admin/widgets/login_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final models = <KreditModel>[].obs;

  BuildContext context;

  HomeController({required this.context});

  @override
  void onInit() {
    Future.delayed(Duration.zero, () {
      getAllData(context);
    });
    super.onInit();
  }

  getAllData(BuildContext context) {
    Loader.show(context);

    final firestore = FirebaseFirestore.instance;
    final simulationRef = firestore.collection('simulations');

    simulationRef.where('status', isEqualTo: 'Menunggu').get().then((value) {
      Loader.close(context);

      final docs = value.docChanges;

      for (var element in docs) {
        final data = element.doc.data();
        final model = KreditModel.fromJson(data!);
        model.id = element.doc.id;
        models.add(model);
      }
    }).catchError((error) {
      Loader.close(context);
      GetSnackbar.show('Error', error.toString(), false);
    });
  }

  getAllDataNoLoading() {
    final firestore = FirebaseFirestore.instance;
    final simulationRef = firestore.collection('simulations');

    simulationRef.orderBy('createdDate').get().then((value) {
      final docs = value.docChanges;

      for (var element in docs) {
        final data = element.doc.data();
        final model = KreditModel.fromJson(data!);

        models.clear();
        models.add(model);
      }
    }).catchError((error) {
      GetSnackbar.show('Error', error.toString(), false);
    });
  }
}
