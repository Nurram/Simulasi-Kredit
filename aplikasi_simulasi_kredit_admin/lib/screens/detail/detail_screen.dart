import 'package:aplikasi_simulasi_kredit_admin/models/kredit.dart';
import 'package:aplikasi_simulasi_kredit_admin/screens/detail/detail_controller.dart';
import 'package:aplikasi_simulasi_kredit_admin/screens/private_data/private_data_screen.dart';
import 'package:aplikasi_simulasi_kredit_admin/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  final KreditModel model;

  const DetailScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late KreditModel kreditModel;
  final _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des'
  ];

  @override
  void initState() {
    kreditModel = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian'),
      ),
      body: SafeArea(
        child: Card(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GetX<DetailController>(
                  init: Get.put(
                    DetailController(
                        context: context, userId: kreditModel.userId!),
                  ),
                  builder: (DetailController controller) {
                    final user = controller.user.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 16, bottom: 8),
                          child: Text(
                            'Data Peminjam',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        _buildListTile(
                          'NIK Peminjam',
                          user.nik,
                        ),
                        _buildListTile(
                          'Nama Peminjam',
                          user.name,
                        ),
                        _buildListTile(
                          'Alamat Peminjam',
                          user.address,
                        ),
                        _buildListTile(
                          'Nama Usaha Peminjam',
                          user.company,
                        ),
                        _buildListTile(
                          'Nomor Telepon Peminjam',
                          user.phone,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(
                            color: Colors.black54,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Pengajuan Pinjaman',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        _buildListTile('Lama Pinjaman',
                            '${kreditModel.durationLoan} Bulan\n(${(kreditModel.durationLoan / 12).toStringAsFixed(2)} tahun)'),
                        _buildListTile('Bunga Pertahun',
                            '${kreditModel.interestLoan}% / tahun\n(${(kreditModel.interestLoan / 12).toStringAsFixed(2)}% / bulan)'),
                        _buildListTile(
                          'Cicilan Per Bulan',
                          _calculateInstalment(kreditModel),
                        ),
                        _buildListTile('Mulai Meminjam',
                            '${kreditModel.startMonth} ${kreditModel.startYear}'),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(
                            color: Colors.black54,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Tabel Angsuran',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Table(children: _buildTableItem(kreditModel)),
                        const SizedBox(
                          height: 32,
                        ),
                        MyElevatedButton(
                          text: 'Verifikasi',
                          onPressed: () => Get.to(
                            () => PrivateDataScreen(
                              model: kreditModel,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(String text, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$text: ',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.end,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }

  String _calculateInstalment(KreditModel model) {
    double monthlyLoan = model.totalLoan / model.durationLoan;
    double interest = model.totalLoan * (model.interestLoan / 12) / 100;
    return _currencyFormat(monthlyLoan + interest);
  }

  String _currencyFormat(dynamic value) {
    final formatter = NumberFormat("#,##0", "en_US");
    final formatted = formatter.format(value);

    return 'Rp$formatted';
  }

  List<TableRow> _buildTableItem(KreditModel model) {
    final items = <TableRow>[
      TableRow(decoration: const BoxDecoration(color: Colors.blue), children: [
        _buildRowItem('Periode'),
        _buildRowItem('Angsuran Bunga'),
        _buildRowItem('Angsuran Pokok'),
        _buildRowItem('Total Angsuran'),
        _buildRowItem('Sisa Pinjaman'),
      ]),
      TableRow(children: [
        _buildRowItem('${model.startMonth} ${model.startYear}'),
        _buildRowItem('0'),
        _buildRowItem('0'),
        _buildRowItem('0'),
        _buildRowItem(_currencyFormat(model.totalLoan)),
      ]),
    ];

    final monthlyLoan = model.totalLoan / model.durationLoan;
    final instalment = model.totalLoan * (model.interestLoan / 12) / 100;
    double totalLoan = model.totalLoan;

    for (int i = 1; i <= model.durationLoan; i++) {
      totalLoan -= monthlyLoan;
      final currentDate = DateTime.parse(model.loanDate).add(
        Duration(days: 30 * i),
      );

      final row = TableRow(children: [
        _buildRowItem('${_months[currentDate.month - 1]} ${currentDate.year}'),
        _buildRowItem(_currencyFormat(instalment)),
        _buildRowItem(_currencyFormat(monthlyLoan)),
        _buildRowItem(_currencyFormat(instalment + monthlyLoan)),
        _buildRowItem(_currencyFormat(totalLoan)),
      ]);

      items.add(row);
    }

    items.add(
        TableRow(decoration: BoxDecoration(color: Colors.blue[200]), children: [
      _buildRowItem('Total'),
      _buildRowItem(_currencyFormat(instalment * model.durationLoan)),
      _buildRowItem(_currencyFormat(monthlyLoan * model.durationLoan)),
      _buildRowItem(
          _currencyFormat((instalment + monthlyLoan) * model.durationLoan)),
      _buildRowItem(''),
    ]));

    return items;
  }

  Widget _buildRowItem(String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Text(
        data,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
