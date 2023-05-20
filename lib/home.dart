import 'package:flutter/material.dart';
import 'package:praktpm_projekakhir/konversi_uang.dart';
import 'package:praktpm_projekakhir/konversi_waktu.dart';
import 'package:praktpm_projekakhir/main.dart';
import 'package:praktpm_projekakhir/profile.dart';
import 'package:praktpm_projekakhir/rekomapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final VoidCallback signOut;
  const HomePage({super.key, required this.signOut});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  int _selectedNavbar = 0;
  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  final List<String> _list = [
    "Profil",
    "Konversi Mata Uang",
    "Konversi Waktu",
    "API"
  ];

  final List<Widget> _listMenu = [
    ProfilePage(),
    KonversiUangPage(),
    KonversiWaktuPage(),
    RekomAPI()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_list[_selectedNavbar]),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xFF2D6A4F),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(
              Icons.logout_rounded,
            ),
          )
        ],
      ),
      body: _listMenu[_selectedNavbar],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Konversi Uang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Konversi Waktu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'API',
          ),
        ],
        currentIndex: _selectedNavbar,
        selectedItemColor: Color(0xFFCCFF33),
        unselectedItemColor: Colors.white,
        backgroundColor: Color(0xFF52B788),
        showUnselectedLabels: true,
        onTap: _changeSelectedNavBar,
      ),
    );
  }
}
