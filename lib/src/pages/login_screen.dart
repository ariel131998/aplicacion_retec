import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Login retec'),
        title: Image.asset('assets/fondo_login.jpg', fit: BoxFit.cover)
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/ClienteScreen');
          },
          child:  const Text('ir')
        )
      ),
    );
  }
}
