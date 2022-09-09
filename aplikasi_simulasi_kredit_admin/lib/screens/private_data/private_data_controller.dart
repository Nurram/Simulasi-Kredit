import 'package:aplikasi_simulasi_kredit_admin/screens/home/home_screen.dart';
import 'package:aplikasi_simulasi_kredit_admin/widgets/get_snackbar.dart';
import 'package:aplikasi_simulasi_kredit_admin/widgets/login_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PrivateDataController extends GetxController {
  final images = <String, String>{}.obs;

  BuildContext context;
  String userId;

  PrivateDataController({required this.context, required this.userId});

  final imageUrls = <String>[];

  _getDocuments(BuildContext context, String id) async {
    Loader.show(context);

    final storage = FirebaseStorage.instance;
    final documentsRef = storage.ref('documents/$id');

    documentsRef.listAll().then((value) async {
      final data = value.items;
      // ignore: avoid_function_literals_in_foreach_calls
      data.forEach((element) async {
        final url = await element.getDownloadURL();
        imageUrls.add(url);
      });

      final ktp = await data.first.getDownloadURL();
      final kk = await data[1].getDownloadURL();
      final siu = await data.last.getDownloadURL();

      images.addAll({'ktp': ktp, 'kk': kk, 'siu': siu});
      Loader.close(context);
    });
  }

  changeStatus(String id, String status) async {
    Loader.show(context);
    final firestore = FirebaseFirestore.instance;
    final simulationsRef = firestore.collection("simulations");

    simulationsRef.doc(id).update({'status': status}).then((value) {
      Loader.close(context);
      Get.offAll(
        () => const HomeScreen(),
      );
    }).catchError((error) {
      error as FirebaseException;
      Loader.close(context);
      GetSnackbar.show('Error', error.message.toString(), false);
    });
  }

  @override
  void onInit() {
    Future.delayed(Duration.zero, () {
      _getDocuments(context, userId);
    });
    super.onInit();
  }
}
