import 'package:aplikasi_simulasi_kredit/models/kredit.dart';
import 'package:aplikasi_simulasi_kredit/models/user.dart';
import 'package:aplikasi_simulasi_kredit/screens/account/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/elevated_button.dart';
import '../../widgets/text_form_field.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _key = GlobalKey<FormState>();

  final _nikCtr = TextEditingController();
  final _nameCtr = TextEditingController();
  final _birthCtr = TextEditingController();
  final _companyCtr = TextEditingController();
  final _addressCtr = TextEditingController();
  final _phoneCtr = TextEditingController();

  final _nikNode = FocusNode();
  final _nameNode = FocusNode();
  final _birthNode = FocusNode();
  final _companyNode = FocusNode();
  final _addressNode = FocusNode();
  final _phoneNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail akun'),
      ),
      body: GetX<AccountController>(
          init: Get.put(
            AccountController(context: context),
          ),
          builder: (AccountController controller) {
            final data = controller.userData;
            data.isNotEmpty ? _initData(data.first) : null;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormField(
                            readOnly: true,
                            focusNode: _nikNode,
                            textEditingController: _nikCtr,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Field harus di isi!';
                              } else if (value.length > 16) {
                                return 'Masukan nomor nik yang valid!';
                              }
                            },
                            labelText: 'NIK',
                            textInputType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormField(
                            readOnly: true,
                            focusNode: _nameNode,
                            textEditingController: _nameCtr,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Field harus di isi!';
                              }
                            },
                            labelText: 'Nama',
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormField(
                            readOnly: true,
                            focusNode: _birthNode,
                            textEditingController: _birthCtr,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Field harus di isi!';
                              }
                            },
                            labelText: 'Tempat, Tanggal Lahir',
                            hintText: 'Kota, 01 Januari 2022',
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormField(
                            readOnly: true,
                            focusNode: _companyNode,
                            textEditingController: _companyCtr,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Field harus di isi!';
                              }
                            },
                            labelText: 'Nama Perusahaan',
                            textInputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormField(
                            readOnly: true,
                            focusNode: _addressNode,
                            textEditingController: _addressCtr,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Field harus di isi!';
                              }
                            },
                            labelText: 'Alamat',
                            textInputType: TextInputType.multiline,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyTextFormField(
                            readOnly: true,
                            focusNode: _phoneNode,
                            textEditingController: _phoneCtr,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Field harus di isi!';
                              } else if (!value.startsWith('08') ||
                                  value.length != 12) {
                                return 'Masukan nomor telepon yang valid!';
                              }
                            },
                            labelText: 'Nomor Telepon',
                            hintText: '08xxxxxxxxxx',
                            textInputType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          MyElevatedButton(
                            text: 'Kembali',
                            onPressed: () => Get.back(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  _initData(UserModel data) {
    _nikCtr.text = data.nik;
    _nameCtr.text = data.name;
    _birthCtr.text = data.birth;
    _companyCtr.text = data.company;
    _addressCtr.text = data.address;
    _phoneCtr.text = data.phone;
  }
}
