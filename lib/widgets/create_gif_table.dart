import 'package:flutter/material.dart';

class CreateGifTable extends StatelessWidget {
  const CreateGifTable({
    super.key,
    required this.snapshot,
    required this.getCount,
    required this.search, required this.onTap,
  });

  final String? search;
  final AsyncSnapshot snapshot;
  final Function(List) getCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: getCount(snapshot.data['data']),
      itemBuilder: (context, index) {
        if (search == null || index < snapshot.data['data'].length) {
          return GestureDetector(
            child: Image.network(
              snapshot.data['data'][index]['images']['fixed_height']['url'],
              height: 200.0,
              fit: BoxFit.cover,
            ),
          );
        }

        return GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
                size: 70.0,
              ),
              Text(
                'Carregar mais...',
                style: TextStyle(color: Colors.white, fontSize: 22.0),
              ),
            ],
          ),
        );
      },
    );
  }
}
