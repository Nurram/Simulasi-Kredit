import 'package:aplikasi_simulasi_kredit_admin/models/kredit.dart';
import 'package:aplikasi_simulasi_kredit_admin/screens/private_data/private_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/elevated_button.dart';

class PrivateDataScreen extends StatefulWidget {
  final KreditModel model;
  const PrivateDataScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<PrivateDataScreen> createState() => _PrivateDataScreenState();
}

class _PrivateDataScreenState extends State<PrivateDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dokumen Peminjam'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GetX<PrivateDataController>(
            init: Get.put(PrivateDataController(
                context: context, userId: widget.model.userId!)),
            builder: (PrivateDataController controller) {
              final images = controller.images.value;

              return Column(children: [
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('KTP Peminjam')),
                Image.network(images['ktp'] ??
                    'https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png?w=128'),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('KK Peminjam')),
                Image.network(images['kk'] ??
                    'https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png?w=128'),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('Surat Ijin Usaha Peminjam')),
                Image.network(images['siu'] ??
                    'https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png?w=128'),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: MyElevatedButton(
                    text: 'Diterima',
                    onPressed: () =>
                        controller.changeStatus(widget.model.id!, 'Diterima'),
                  ),
                ),
                TextButton(
                  child: const Text(
                    'Ditolak',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () =>
                      controller.changeStatus(widget.model.id!, 'Ditolak'),
                ),
              ]);
            },
          ),
        ),
      ),
    );
  }
}
