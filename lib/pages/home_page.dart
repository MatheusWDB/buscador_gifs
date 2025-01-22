import 'dart:convert';

import 'package:buscador_gifs/widgets/create_gif_table.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? search;
  int offset = 0;
  int page = 0;
  bool error = false;

  Future<Map> getGifs() async {
    http.Response response;

    if (search == null || search!.isEmpty) {
      response = await http.get(Uri.parse(
          'https://api.giphy.com/v1/gifs/trending?api_key=CsprqEHK8d2IEGolVKilJHiuv7cma7eC&limit=20&offset=$offset&rating=g&bundle=messaging_non_clips'));
    } else {
      response = await http.get(Uri.parse(
          'https://api.giphy.com/v1/gifs/search?api_key=CsprqEHK8d2IEGolVKilJHiuv7cma7eC&q=$search&limit=20&offset=$offset&rating=g&lang=pt&bundle=messaging_non_clips'));
    }
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(
            'https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              cursorColor: Colors.white,
              decoration: InputDecoration(
                labelText: 'Pesquisar',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
              onSubmitted: (value) {
                updateVariables(null, value);
              },
            ),
          ),
          Flexible(
            child: FutureBuilder(
              future: getGifs(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: SizedBox(
                        width: 100.0,
                        height: 100.0,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5.0,
                        ),
                      ),
                    );
                  default:
                    if (snapshot.hasError || snapshot.data?['data'].isEmpty) {
                      error = true;
                      return Center(
                        child: Text(
                          'Error: ${snapshot.data!['meta']['msg']}\nStatus: ${snapshot.data!['meta']['status']}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                          ),
                        ),
                      );
                    }
                    error == false;
                    return CreateGifTable(
                      snapshot: snapshot,
                      search: search,
                    );
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 50,
                color: Colors.white,
                disabledColor: const Color.fromARGB(59, 255, 255, 255),
                onPressed: page == 0 || error == true
                    ? null
                    : () {
                        updateVariables('decrement', search);
                      },
                icon: Icon(Icons.arrow_left),
              ),
              Text(
                '$page',
                style: TextStyle(color: Colors.white),
              ),
              IconButton(
                iconSize: 50,
                color: Colors.white,
                disabledColor: const Color.fromARGB(59, 255, 255, 255),
                onPressed: error == true
                    ? null
                    : () {
                        updateVariables('increment', search);
                      },
                icon: Icon(Icons.arrow_right),
              )
            ],
          )
        ],
      ),
    );
  }

  void updateVariables(String? incrementOrDecrement, String? search) {
    setState(() {
      switch (incrementOrDecrement) {
        case 'increment':
          page++;
          break;
        case 'decrement':
          page--;
          break;
        default:
          page = 0;
          break;
      }

      error == true ? page = 0 : null;

      this.search = search;
      offset = page * 20;
    });
  }
}
