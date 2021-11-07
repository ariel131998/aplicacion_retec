import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClienteScreen extends StatelessWidget {
  const ClienteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Cliente'),
      ),
    );
  }
}
