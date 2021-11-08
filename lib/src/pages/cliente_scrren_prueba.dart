import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_retec/tema/palette.dart';
class ClienteScreen2 extends StatefulWidget {
  const ClienteScreen2({Key? key}) : super(key: key);
  @override
  State<ClienteScreen2> createState() => _ClienteScreen2();
  
}

class _ClienteScreen2 extends State<ClienteScreen2>{
  int _selectedIndex = 0;
  static const TextStyle optionStyle = 
    TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
    );
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Inicio',
      style: optionStyle,
    ),
    Text(
      'Index 1: Explorar',
      style: optionStyle,
    ),
    Text(
      'Index 2: Pedidos',
      style: optionStyle,
    ),
    Text(
      'Index 3: Cuenta',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.contain, // otherwise the logo will be tiny
                  child: ImagenLogo(),
                ), 
              ), 
              Container(
                child: TextoAppBar(),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              ),
            ],   
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
            backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.backpack_sharp),//buscar icono externo
            label: 'Pedidos',
            backgroundColor: Colors.black87,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Cuenta',
            backgroundColor: Colors.black87,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Palette.kToDark,
        //backgroundColor: Colors.amber,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget ImagenLogo() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Image.asset(
        'assets/Retec_Blanco_bordes.png',
        height: 80.0,
        //alignment: Alignment.topLeft,
      );
    });
  }

  Widget TextoAppBar() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot stapshot){
        return Text(
          'Encuentra al personal necesario para tu problema', 
          style: TextStyle(
          color: Colors.white, 
          fontSize: 19.0,     
          ),   
        );
      }
    );
  }
}