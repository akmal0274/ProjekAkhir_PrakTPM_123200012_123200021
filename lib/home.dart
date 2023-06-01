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
    "Digimon Katalog",
    "Konversi Mata Uang",
    "Konversi Waktu",
    "Profil"
  ];

  final List<Widget> _listMenu = [
    CataloguePage(),
    KonversiUangPage(),
    KonversiWaktuPage(),
    ProfilePage(),
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
            icon: Icon(Icons.list_outlined),
            label: 'Digimon Katalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Konversi Uang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Konversi Waktu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_circle),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedNavbar,
        selectedItemColor: Color(0xFFCCFF33),
        unselectedItemColor: Color.fromARGB(255, 12, 59, 8),
        backgroundColor: Color.fromARGB(255, 26, 37, 32),
        showUnselectedLabels: true,
        onTap: _changeSelectedNavBar,
      ),
    );
  }
}
