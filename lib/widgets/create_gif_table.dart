import 'package:flutter/material.dart';

class CreateGifTable extends StatelessWidget {
  const CreateGifTable({
    super.key,
    required this.snapshot,
    required this.contextS,
  });

  final BuildContext contextS;
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
          child: Image.network(
            snapshot.data['data'][index]['images']['fixed_height']['url'],
            height: 200.0,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
