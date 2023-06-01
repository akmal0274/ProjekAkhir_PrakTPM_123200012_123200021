import 'package:flutter/material.dart';
import 'package:praktpm_projekakhir/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D6A4F),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 60, vertical: 30),
            padding: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(100), // Image radius
                    child: Image.asset(
                      "images/foto.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Color(0xFF52B788),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Muhammad Hafizh Akmal",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Color(0xFF52B788),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "123200012",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Color(0xFF52B788),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Kesan: Menantang",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Color(0xFF52B788),
                      borderRadius: BorderRadius.circular(10)),
                  child: Expanded(
                    child: Text(
                      "Pesan: Semoga bapak sehat selalu dan bisa mengajar terus",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
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
