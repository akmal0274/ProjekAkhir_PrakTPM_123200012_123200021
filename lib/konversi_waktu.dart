import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class KonversiWaktuPage extends StatefulWidget {
  const KonversiWaktuPage({super.key});

  @override
  State<KonversiWaktuPage> createState() => _KonversiWaktuPageState();
}

class _KonversiWaktuPageState extends State<KonversiWaktuPage> {
  late String _timezoneName;
  late Duration _timezoneOffset;
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = DateTime.now();
    _timezoneName = 'UTC';
    _timezoneOffset = const Duration(hours: 0);
  }

  void _changeTimezone(Duration offset, String timezone) async {
    await initializeDateFormatting(timezone, null);
    setState(() {
      _timezoneOffset = offset;
      _timezoneName = timezone;
    });
  }

  void _list(String timezone) {
    if (timezone == 'UTC') {
      _changeTimezone(const Duration(hours: 0), 'UTC');
    } else if (timezone == 'US & Canada') {
      _changeTimezone(const Duration(hours: -8), 'US & Canada');
    } else if (timezone == 'Paris/Madrid') {
      _changeTimezone(const Duration(hours: -8), 'Paris/Madrid');
    } else if (timezone == 'Indonesia/WIT') {
      _changeTimezone(const Duration(hours: 9), 'Indonesia/WIT');
    } else if (timezone == 'Indonesia/WITA') {
      _changeTimezone(const Duration(hours: 8), 'Indonesia/WITA');
    } else if (timezone == 'Indonesia/WIB') {
      _changeTimezone(const Duration(hours: 7), 'Indonesia/WIB');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D6A4F),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Selected time:',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                DateFormat.jms()
                    .format(_selectedDateTime.toUtc().add(_timezoneOffset)),
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButton<String>(
                  dropdownColor: Colors.black,
                  value: _timezoneName,
                  items: <String>[
                    'UTC',
                    'US & Canada',
                    'Paris/Madrid',
                    'Indonesia/WIB',
                    'Indonesia/WITA',
                    'Indonesia/WIT'
                  ].map((String value) {
                    return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ));
                  }).toList(),
                  onChanged: ((value) {
                    setState(() {
                      _timezoneName = value ?? 'UTC';
                    });
                  })),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF52B788),
                      padding: EdgeInsets.symmetric(horizontal: 100)),
                  onPressed: () {
                    _list(_timezoneName);
                  },
                  child: Text("Change")),
            ]),
      )),
    );
  }
}
