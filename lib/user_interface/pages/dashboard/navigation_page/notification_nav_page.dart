

import 'package:flutter/material.dart';

class NotificationNavPage extends StatelessWidget {
  const NotificationNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade200,
      body: Center(
        child: Icon(Icons.notifications, size: 90,),
      ),
    );
  }
}
