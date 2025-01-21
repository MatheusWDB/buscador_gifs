import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              Share.share(gif['images']['fixed_height']['url']);
            },
            icon: Icon(
              Icons.share,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(gif['images']['fixed_height']['url']),
      ),
    );
  }
}
