import 'package:flutter/material.dart';

class TestImage extends StatelessWidget {
  const TestImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      ),
      body: Container(
        child: Image(image: AssetImage('assets/images/imageone.png',),fit: BoxFit.cover,),
      ),
    );
  }
}
