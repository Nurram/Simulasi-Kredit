import 'dart:io';

import 'package:aplikasi_simulasi_kredit/models/kredit.dart';
import 'package:aplikasi_simulasi_kredit/screens/private_data/private_data_controller.dart';
import 'package:aplikasi_simulasi_kredit/widgets/elevated_button.dart';
import 'package:aplikasi_simulasi_kredit/widgets/get_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PrivateDataScreen extends StatefulWidget {
  final KreditModel model;
  const PrivateDataScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<PrivateDataScreen> createState() => _PrivateDataScreenState();
}

class _PrivateDataScreenState extends State<PrivateDataScreen> {
  late PrivateDataController _controller;

  File? _ktp;
  File? _kk;
  File? _siu;

  bool _showBtn = false;

  @override
  void initState() {
    _controller = PrivateDataController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lengkapi data diri anda'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('Masukan KTP anda (File: jpg, jpeg, png, webp)')),
            Container(
              color: Colors.grey[300],
              width: double.infinity,
              child: TextButton(
                onPressed: () => _pickFile(0),
                child: _ktp == null
                    ? const Icon(
                        Icons.image_search_outlined,
                        color: Colors.black87,
                      )
                    : Image.file(
                        _ktp!,
                        width: double.infinity,
                      ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('Masukan KK anda (File: jpg, jpeg, png, webp)')),
            Container(
              color: Colors.grey[300],
              width: double.infinity,
              child: TextButton(
                onPressed: () => _pickFile(1),
                child: _kk == null
                    ? const Icon(
                        Icons.image_search_outlined,
                        color: Colors.black87,
                      )
                    : Image.file(
                        _kk!,
                        width: double.infinity,
                      ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                    'Masukan surat ijin usaha anda (File: jpg, jpeg, png, webp)')),
            Container(
              color: Colors.grey[300],
              width: double.infinity,
              child: TextButton(
                onPressed: () => _pickFile(2),
                child: _siu == null
                    ? const Icon(
                        Icons.image_search_outlined,
                        color: Colors.black87,
                      )
                    : Image.file(
                        _siu!,
                        width: double.infinity,
                      ),
              ),
            ),
            Visibility(
              visible: _showBtn,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: MyElevatedButton(
                  text: 'Ajukan',
                  onPressed: () => _controller.saveSimulation(
                      context, widget.model, _ktp!, _kk!, _siu!),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  _pickFile(int type) async {
    final fileResult = await FilePicker.platform.pickFiles();

    if (fileResult != null) {
      final file = File(fileResult.files.single.path!);

      if (_checkFileExtension(file)) {
        if (type == 0) {
          _ktp = file;
        } else if (type == 1) {
          _kk = file;
        } else {
          _siu = file;
        }
      } else {
        GetSnackbar.show(
            'Error', 'File harus berformat jpg, jgeg, png atau webp!', false);
      }
    }

    _showBtn = _ktp != null && _kk != null && _siu != null;
    setState(() {});
  }

  _checkFileExtension(File file) {
    final supportedExtensions = ['jpg', 'jpeg', 'png', 'webp'];

    final filePath = file.path;
    final dotIndex = filePath.lastIndexOf('.');
    final fileExtension = filePath.substring(dotIndex + 1);

    return supportedExtensions.contains(fileExtension);
  }
}
