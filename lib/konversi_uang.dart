import 'package:flutter/material.dart';

class KonversiUangPage extends StatefulWidget {
  const KonversiUangPage({super.key});

  @override
  State<KonversiUangPage> createState() => _KonversiUangPageState();
}

class _KonversiUangPageState extends State<KonversiUangPage> {
  late String choose1;
  late String choose2;
  late String _result;
  late double temp;

  late String _jumlah;

  @override
  void initState() {
    super.initState();
    choose1 = 'IDR';
    choose2 = 'IDR';
    _result = '';
    _jumlah = '';
    temp = 0;
  }

  void _hasil() {
    if (choose1 == 'IDR') {
      // dari IDR ke mata uang lain
      if (choose2 == 'IDR') {
        setState(() {
          temp = double.parse(_jumlah);
          _result = temp.toStringAsFixed(4);
        });
      } else if (choose2 == 'USD') {
        setState(() {
          temp = double.parse(_jumlah) / 14200;
          _result = temp.toStringAsFixed(4);
        });
      } else if (choose2 == 'SGD') {
        setState(() {
          temp = double.parse(_jumlah) / 11000;
          _result = temp.toStringAsFixed(4);
        });
      } else if (choose2 == 'MYR') {
        setState(() {
          temp = double.parse(_jumlah) / 3200;
          _result = temp.toStringAsFixed(4);
        });
      }
    } else if (choose1 == 'USD') {
      // dari USD ke mata uang lain
      if (choose2 == 'USD') {
        setState(() {
          temp = double.parse(_jumlah);
          _result = temp.toStringAsFixed(4);
        });
      } else if (choose2 == 'IDR') {
        setState(() {
          temp = double.parse(_jumlah) * 14200;
          _result = temp.toStringAsFixed(4);
        });
      } else if (choose2 == 'SGD') {
        setState(() {
          temp = double.parse(_jumlah) * 1.34;
          _result = temp.toStringAsFixed(4);
        });
      } else if (choose2 == 'MYR') {
        setState(() {
          temp = double.parse(_jumlah) * 4.54;
          _result = temp.toStringAsFixed(4);
        });
      }
    } else if (choose1 == 'SGD') {
      // dari SGD ke mata uang lain
      if (choose2 == 'SGD') {
        setState(() {
          temp = double.parse(_jumlah);
          _result = temp.toStringAsFixed(4);
        });
      } else if (choose2 == 'IDR') {
        setState(() {
          temp = double.parse(_jumlah) * 11000;
          _result = temp.toStringAsFixed(4);
        });
      } else if (choose2 == 'USD') {
        setState(() {
          temp = double.parse(_jumlah) * 0.74;
          _result = temp.toStringAsFixed(4);
        });
      } else if (choose2 == 'MYR') {
        setState(() {
          temp = double.parse(_jumlah) * 3.38;
          _result = temp.toStringAsFixed(4);
        });
      }
    } else if (choose1 == 'MYR') {
      // dari MYR ke mata uang lain
      if (choose2 == 'MYR') {
        setState(() {
          temp = double.parse(_jumlah);
          _result = temp.toStringAsFixed(4);
        });
      } else if (choose2 == 'IDR') {
        setState(() {
          temp = double.parse(_jumlah) * 3200;
          _result = temp.toStringAsFixed(4);
        });
      } else if (choose2 == 'USD') {
        setState(() {
          temp = double.parse(_jumlah) * 0.22;
          _result = temp.toStringAsFixed(4);
        });
      } else if (choose2 == 'SGD') {
        setState(() {
          temp = double.parse(_jumlah) * 0.3;
          _result = temp.toStringAsFixed(4);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D6A4F),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          TextField(
            style: TextStyle(color: Colors.white),
            onChanged: (value) {
              setState(() {
                _jumlah = value;
              });
            },
            decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                labelText: "Input Jumlah Uang",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white))),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                  dropdownColor: Colors.black,
                  value: choose1,
                  items:
                      <String>['IDR', 'USD', 'SGD', 'MYR'].map((String value) {
                    return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.white),
                        ));
                  }).toList(),
                  onChanged: ((value) {
                    setState(() {
                      choose1 = value ?? 'IDR';
                    });
                  })),
              DropdownButton<String>(
                  dropdownColor: Colors.black,
                  value: choose2,
                  items:
                      <String>['IDR', 'USD', 'SGD', 'MYR'].map((String value) {
                    return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.white),
                        ));
                  }).toList(),
                  onChanged: ((value) {
                    setState(() {
                      choose2 = value ?? 'IDR';
                    });
                  })),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xFF52B788),
                  padding: EdgeInsets.symmetric(horizontal: 100)),
              onPressed: () {
                print(choose1);
                print(choose2);
                print(_jumlah);
                _hasil();
              },
              child: Text("Convert")),
          SizedBox(
            height: 15,
          ),
          Text(
            _result,
            style: TextStyle(fontSize: 20, color: Colors.white),
          )
        ]),
      )),
    );
  }
}
