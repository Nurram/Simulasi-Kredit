import 'package:aplikasi_simulasi_kredit_admin/screens/register/register_controller.dart';
import 'package:aplikasi_simulasi_kredit_admin/widgets/elevated_button.dart';
import 'package:aplikasi_simulasi_kredit_admin/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DaftarScreen extends StatefulWidget {
  const DaftarScreen({Key? key}) : super(key: key);

  @override
  State<DaftarScreen> createState() => _DaftarScreenState();
}

class _DaftarScreenState extends State<DaftarScreen> {
  final _key = GlobalKey<FormState>();

  final _usernameCtr = TextEditingController();
  final _passwordCtr = TextEditingController();
  final _nikCtr = TextEditingController();
  final _nameCtr = TextEditingController();
  final _birthCtr = TextEditingController();
  final _companyCtr = TextEditingController();
  final _addressCtr = TextEditingController();
  final _phoneCtr = TextEditingController();

  final _usernameNode = FocusNode();
  final _passwordNode = FocusNode();
  final _nikNode = FocusNode();
  final _nameNode = FocusNode();
  final _birthNode = FocusNode();
  final _companyNode = FocusNode();
  final _addressNode = FocusNode();
  final _phoneNode = FocusNode();

  final _controller = RegisterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Text(
                    'Daftar',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      MyTextFormField(
                        focusNode: _usernameNode,
                        textEditingController: _usernameCtr,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Field harus di isi!';
                          }
                        },
                        labelText: 'Username',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyTextFormField(
                        focusNode: _passwordNode,
                        textEditingController: _passwordCtr,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Field harus di isi!';
                          } else if (value.length < 6) {
                            return 'Password kurang dari 6 karakter!';
                          }
                        },
                        labelText: 'Password',
                        obscureText: true,
                        maxLines: 1,
                        textInputType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyTextFormField(
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
                        text: 'Daftar',
                        onPressed: () => _registerUser(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Sudah memiliki akun?'),
                          const SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            child: Text(
                              'Masuk',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            onTap: () => Get.back(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _registerUser() {
    if (_key.currentState!.validate()) {
      _controller.registerUser(context, {
        'username': _usernameCtr.text.toString(),
        'password': _passwordCtr.text.toString(),
        'nik': _nikCtr.text.toString(),
        'name': _nameCtr.text.toString(),
        'birth': _birthCtr.text.toString(),
        'company': _companyCtr.text.toString(),
        'address': _addressCtr.text.toString(),
        'phone': _phoneCtr.text.toString()
      });
    }
  }
}
