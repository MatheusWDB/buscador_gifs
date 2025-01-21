import 'package:flutter/material.dart';

class GifPage extends StatelessWidget {
  const GifPage({
    super.key,
    required this.gif,
  });

  final Map gif;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gif['title']),
        titleTextStyle: TextStyle(fontSize: 16.0),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(gif['images']['fixed_height']['url']),
      ),
    );
  }
}
