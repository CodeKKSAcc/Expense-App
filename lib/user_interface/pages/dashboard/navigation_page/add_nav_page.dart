

import 'package:flutter/material.dart';

class AddNavPage extends StatelessWidget {
  const AddNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade200,
      body: Center(
        child: Icon(Icons.add, size: 90,),
      ),
    );
  }
}
