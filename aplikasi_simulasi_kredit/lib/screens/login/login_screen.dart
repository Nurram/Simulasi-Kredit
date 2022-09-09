import 'package:aplikasi_simulasi_kredit/screens/home/home_screen.dart';
import 'package:aplikasi_simulasi_kredit/screens/login/login_controller.dart';
import 'package:aplikasi_simulasi_kredit/screens/register/register_screen.dart';
import 'package:aplikasi_simulasi_kredit/widgets/elevated_button.dart';
import 'package:aplikasi_simulasi_kredit/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MasukScreen extends StatefulWidget {
  const MasukScreen({Key? key}) : super(key: key);

  @override
  State<MasukScreen> createState() => _MasukScreenState();
}

class _MasukScreenState extends State<MasukScreen> {
  final _key = GlobalKey<FormState>();

  final _usernameCtr = TextEditingController();
  final _passwordCtr = TextEditingController();

  final _usernameNode = FocusNode();
  final _passwordNode = FocusNode();

  final _controller = LoginController();

  @override
  void initState() {
    if (_controller.isLoggedIn()) {
      Future.delayed(Duration.zero, () {
        Get.offAll(() => const HomeScreen());
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Text(
                    'Masuk',
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
                            return 'Field harus diisi!';
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
                            return 'Field harus diisi!';
                          }
                        },
                        labelText: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      MyElevatedButton(
                          text: 'Masuk',
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              _controller.login(context, {
                                'username': _usernameCtr.text.toString(),
                                'password': _passwordCtr.text.toString()
                              });
                            }
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Belum memiliki akun?'),
                          const SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            child: Text(
                              'Daftar',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            onTap: () => Get.to(() => const DaftarScreen()),
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
}
