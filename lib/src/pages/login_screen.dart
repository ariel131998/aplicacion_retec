import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/fondo_login.jpg', fit: BoxFit.cover),
        //title: Image.asset('assets/fondo_login.jpg', fit: BoxFit.cover)
        title: const Text('Login retec'),
        //actionsIconTheme: ,
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
