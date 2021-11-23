import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClienteScreen extends StatelessWidget {
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            children: <Widget>[
              SizedBox(height: 22.0),
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
=======
  const ClienteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Cliente'),
>>>>>>> VersionEstable
      ),
      //body: BarraNavegacion(),
    );
  }
<<<<<<< HEAD

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
//Pruebas barra de navegacion.
// class BarraNavegacion  extends StatefulWidget{
//   const BarraNavegacion({Key? key}) : super(key: key);
//   @override
//   State<BarraNavegacion> createState() => _BarraNavegacion();
  
// }

// class _BarraNavegacion {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle = 
//     TextStyle(
//       fontSize: 30,
//       fontWeight: FontWeight.bold
//     );
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text(
//       'Index 0: Inicio',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 1: Explorar',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 2: Pedidos',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 3: Cuenta',
//       style: optionStyle,
//     ),
//   ];

//   void _onItemTapped(int index){
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return (
      
//     );
//   }
// }

//Ejemplos de codigo que ya no se utilizo
//title: Text('Pantalla Cliente', style: TextStyle(color: Colors.white, fontSize: 25.0, ),),
          //leading: Image.asset('assets/Retec_Blanco_SF.png', height: 80.0,),
          //centerTitle: ,



// SizedBox(height:0.5),
                // Container(
                //   child: Image.asset(
                //     'assets/Retec_Blanco_SF.png',
                //     height: 150.0,
                //     //alignment: ,
                //     //alignment: Alignment.topLeft,
                //   ),
                //   alignment: Alignment.topLeft,

                // ),
                // Text('Reteccito')
                //SizedBox(height: 30.0),
                // Column(

                //   children: [
                //     Text('Pantalla Cliente', style: TextStyle(color: Colors.white, fontSize: 10.0, ),),
                //   ],


// ya solo falta trabajar en el body.
=======
}
>>>>>>> VersionEstable
