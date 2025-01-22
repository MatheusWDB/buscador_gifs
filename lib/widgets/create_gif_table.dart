import 'package:buscador_gifs/pages/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';

class CreateGifTable extends StatelessWidget {
  const CreateGifTable({
    super.key,
    required this.snapshot,
    required this.search,
  });

  final String? search;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: snapshot.data['data'].length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: snapshot.data['data'][index]['images']['fixed_height']
                ['url'],
            height: 200.0,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return GifPage(gif: snapshot.data['data'][index]);
              },
            ));
          },
          onLongPress: () {
            Share.share(
                snapshot.data['data'][index]['images']['fixed_height']['url']);
          },
        );
      },
    );
  }
}
