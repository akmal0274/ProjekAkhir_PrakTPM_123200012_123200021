import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RekomAPI extends StatefulWidget {
  const RekomAPI({super.key});

  @override
  State<RekomAPI> createState() => _RekomAPIState();
}

class _RekomAPIState extends State<RekomAPI> {
  late List<dynamic> _hero;

  @override
  void initState() {
    super.initState();
    _hero = [];
    _fetchHero();
  }

  void _fetchHero() async {
    final http.Response response = await http.get(
      Uri.parse('https://api.dazelpro.com/mobile-legends/hero'),
    );
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    setState(() {
      _hero = responseBody['hero'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: _hero.length,
        itemBuilder: (BuildContext context, int index) {
          final Map<String, dynamic> hero = _hero[index];
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => DetailMoviesPage(movie: movie),
              //   ),
              // );
            },
            child: GridTile(
              child: Image.network(
                '${hero['hero_avatar']}',
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
