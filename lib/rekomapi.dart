import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CataloguePage extends StatefulWidget {
  @override
  _CataloguePageState createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
  List<dynamic> digimonData = [];
  List<dynamic> filteredDigimonData = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDigimonData();
  }

  Future<void> fetchDigimonData() async {
    var url = Uri.parse('https://digimon-api.vercel.app/api/digimon');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          digimonData = data;
          filteredDigimonData = data;
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void filterDigimonData(String query) {
    List<dynamic> filteredList = [];

    if (query.isNotEmpty) {
      filteredList = digimonData
          .where((digimon) =>
              digimon['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      filteredList = digimonData;
    }

    setState(() {
      filteredDigimonData = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                filterDigimonData(value);
              },
              decoration: InputDecoration(
                  labelText: 'Search by name',
                  prefixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2D6A4F)))),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredDigimonData.length,
              itemBuilder: (context, index) {
                var digimon = filteredDigimonData[index];

                return GridTile(
                  child: Column(
                    children: [
                      Image.network(
                        digimon['img'],
                        fit: BoxFit.cover,
                        height: 100,
                      ),
                      SizedBox(height: 8),
                      Text(
                        digimon['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Level: ${digimon['level']}',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
