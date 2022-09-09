import 'package:aplikasi_simulasi_kredit/models/kredit.dart';
import 'package:aplikasi_simulasi_kredit/screens/add/add_screen_controller.dart';
import 'package:aplikasi_simulasi_kredit/screens/summary/summary_screen.dart';
import 'package:aplikasi_simulasi_kredit/widgets/elevated_button.dart';
import 'package:aplikasi_simulasi_kredit/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _key = GlobalKey<FormState>();

  final _totalCtr = TextEditingController();
  final _durationCtr = TextEditingController();
  final _interestCtr = TextEditingController();
  final _instalmentCtr = TextEditingController();
  final _interestTypeCtr = TextEditingController();

  final _totalNode = FocusNode();
  final _durationNode = FocusNode();
  final _interestNode = FocusNode();
  final _instalmentNode = FocusNode();
  final _interestTypeNode = FocusNode();

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

  final _years = <String>[];

  var _selectedMonth = 'Jan';
  var _selectedYear = DateTime.now().year;

  @override
  void initState() {
    _instalmentCtr.text = 'BULAN';
    _interestTypeCtr.text = 'FLAT';
    _years.addAll(_getYears());
    Future.delayed(Duration.zero, () {
      AddController().getInterest(context, _interestCtr);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulasi Kredit'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: MyTextFormField(
                        focusNode: _totalNode,
                        textEditingController: _totalCtr,
                        labelText: 'Jumlah Pinjaman',
                        prefix: 'Rp',
                        textInputType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Field masih kosong!';
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: MyTextFormField(
                        focusNode: _durationNode,
                        textEditingController: _durationCtr,
                        labelText: 'Lama Pinjaman (Bulan)',
                        textInputType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Field masih kosong!';
                          } else if (int.parse(value) <= 0) {
                            return 'Masukan nilai yang valid!';
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: MyTextFormField(
                        focusNode: _interestNode,
                        textEditingController: _interestCtr,
                        labelText: 'Bunga Pinjaman',
                        textInputType: TextInputType.number,
                        readOnly: true,
                        validator: (value) {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: MyTextFormField(
                        focusNode: _instalmentNode,
                        textEditingController: _instalmentCtr,
                        labelText: 'Cicilan Tiap',
                        readOnly: true,
                        validator: (value) {}),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 4),
                    child: Text('Mulai Kredit'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedMonth,
                            items: _months
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _selectedMonth = value!;
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedYear.toString(),
                            items: _years
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _selectedYear = int.parse(value!);
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: MyTextFormField(
                        focusNode: _interestTypeNode,
                        textEditingController: _interestTypeCtr,
                        labelText: 'Perhitungan Bunga',
                        readOnly: true,
                        validator: (value) {}),
                  ),
                  const SizedBox(height: 32),
                  MyElevatedButton(
                      text: 'Kalkulasi', onPressed: () => _doCalculate()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<String> _getYears() {
    final years = <String>[];

    for (int i = 5; i > 0; i--) {
      years.add((_selectedYear - i).toString());
    }

    years.add(_selectedYear.toString());

    for (int i = 1; i <= 5; i++) {
      years.add((_selectedYear + i).toString());
    }

    return years;
  }

  _doCalculate() {
    if (_key.currentState!.validate()) {
      final String month =
          (_months.indexOf(_selectedMonth) + 1).toString().padLeft(2, '0');

      final kredit = KreditModel(
          totalLoan: double.parse(_totalCtr.text),
          durationLoan: int.parse(_durationCtr.text),
          interestLoan: double.parse(
            _interestCtr.text.replaceAll('%', ''),
          ),
          instalment: _instalmentCtr.text,
          startMonth: _selectedMonth,
          startYear: _selectedYear,
          interestType: _interestTypeCtr.text,
          loanDate: '$_selectedYear${month}02',
          createdDate: DateTime.now().millisecondsSinceEpoch,
          status: "Menunggu");

      Get.to(
        () => SummaryScreen(model: kredit),
      );
    }
  }
}
