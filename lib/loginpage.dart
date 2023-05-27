import 'package:flutter/material.dart';
import 'package:praktpm_projekakhir/home.dart';
import 'package:praktpm_projekakhir/main.dart';
import 'package:praktpm_projekakhir/registerpage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  var Username = TextEditingController();
  var Password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: Username,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "Masukkan Username",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.people_rounded),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username Wajib Diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: Password,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        labelText: "Masukkan Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: Icon(_showPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password Wajib Diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: const LinearGradient(
                            colors: [Colors.orange, Colors.red]),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (Username.text != "" && Password.text != "") {
                            _onLogin();
                          } else {
                            SnackBar snackBar = SnackBar(
                              content: Text("Tidak Boleh Ada Yang Kosong"),
                              backgroundColor: Colors.redAccent,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text(
                          "MASUK",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // const Icon(Icons.fingerprint , size: 60, color: Colors.teal,),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: 30,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return RegisterPage();
                            }),
                          );
                        },
                        child: Text(
                          "Tidak Punya Akun? Daftar",
                          style: TextStyle(color: Colors.black54),
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return HomePage(
          signOut: signOut,
        );
        break;
    }
  }

  void _onLogin() async {
    final response = await http.post(
        Uri.parse("http://192.168.43.49/dbmobile/users/login.php"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
        },
        body: {
          "uname": Username.text,
          "pass": Password.text
        });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String uname = data['uname'];
    String pass = data['pass'];
    print(Username.text);
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, uname, pass);
      });
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return HomePage(
            signOut: signOut,
          );
        }),
      );
      SnackBar snackBar = SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.greenAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      SnackBar snackBar = SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  savePref(int value, String uname, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("uname", uname);
      preferences.setString("pass", pass);
      preferences.commit();
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const MyApp();
      }),
    );
  }
}
