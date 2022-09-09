import 'package:aplikasi_simulasi_kredit_admin/screens/account/account_screen.dart';
import 'package:aplikasi_simulasi_kredit_admin/screens/detail/detail_screen.dart';
import 'package:aplikasi_simulasi_kredit_admin/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController(context: context));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengajuan'),
        actions: [
          IconButton(
            onPressed: () => Get.to(
              () => const AccountScreen(),
            ),
            icon: const Icon(
              Icons.person,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: GetX<HomeController>(
            init: Get.put(HomeController(context: context)),
            builder: (HomeController controller) {
              return ListView.builder(
                  itemCount: controller.models.length,
                  itemBuilder: (context, index) {
                    final model = controller.models[index];
                    return InkWell(
                      onTap: () => Get.to(
                        () => DetailScreen(model: model),
                      ),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${model.startMonth} ${model.startYear}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    _currencyFormat(model.totalLoan),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Lama pinjaman: ${model.durationLoan} bulan'),
                                  Text(
                                    'Tipe pinjaman: ${model.interestType}',
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }

  String _currencyFormat(dynamic value) {
    final formatter = NumberFormat("#,##0", "en_US");
    final formatted = formatter.format(value);

    return 'Rp$formatted';
  }
}
