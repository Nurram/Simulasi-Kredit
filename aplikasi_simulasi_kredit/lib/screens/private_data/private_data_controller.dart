import 'dart:io';

import 'package:aplikasi_simulasi_kredit/models/kredit.dart';
import 'package:aplikasi_simulasi_kredit/screens/home/home_controller.dart';
import 'package:aplikasi_simulasi_kredit/screens/home/home_screen.dart';
import 'package:aplikasi_simulasi_kredit/widgets/get_snackbar.dart';
import 'package:aplikasi_simulasi_kredit/widgets/login_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PrivateDataController extends GetxController {
  final storage = GetStorage();

  saveSimulation(BuildContext context, KreditModel data, File ktp, File kk,
      File siu) async {
    Loader.show(context);

    final firestore = FirebaseFirestore.instance;
    final simulationRef = firestore.collection('simulations');
    final String? id = storage.read('userId');
    data.userId = id!;

    await simulationRef.add(data.toJson()).then((value) {
      _uploadFile(context, ktp, kk, siu);
    }).catchError((error) {
      Loader.close(context);

      error as FirebaseException;
      GetSnackbar.show('Error', error.message.toString(), false);
    });
  }

  _uploadFile(BuildContext context, File ktp, File kk, File siu) async {
    final String? id = storage.read('userId');
    final firebaseStorage = FirebaseStorage.instance;
    final firebaseStorageRef = firebaseStorage.ref('documents').child(id!);

    final newKtp = await _changeFileNameOnly(ktp, 'ktp').catchError((error) {
      Get.back();
      GetSnackbar.show('Error', 'File not found!', false);
    });
    final newKK = await _changeFileNameOnly(kk, 'kk').catchError((error) {
      Get.back();
      GetSnackbar.show('Error', 'File not found!', false);
    });
    final newSiu = await _changeFileNameOnly(siu, 'siu').catchError((error) {
      Get.back();
      GetSnackbar.show('Error', 'File not found!', false);
    });

    await firebaseStorageRef.child('KTP').putFile(newKtp).then((p0) async {
      await firebaseStorageRef.child('KK').putFile(newKK).then((p0) async {
        await firebaseStorageRef.child('SIU').putFile(newSiu).then((p0) async {
          final homeController = Get.find<HomeController>();
          homeController.getAllDataNoLoading();

          Get.offAll(const HomeScreen());
        }).catchError((error) {
          throw error.toString();
        });
      }).catchError((error) {
        throw error.toString();
      });
    }).catchError((error) {
      Get.back();
      GetSnackbar.show('Error', error.toString(), false);
    });
  }

  Future<File> _changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;

    final dotIndex = path.lastIndexOf('.');
    final fileExtension = path.substring(dotIndex);

    return file.rename(newPath + fileExtension);
  }
}
