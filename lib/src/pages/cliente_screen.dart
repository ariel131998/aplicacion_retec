import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClienteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      /*appBar: AppBar(
        title: const Text('Pantalla Cliente'),
      ),*/
      body: Center(
          child: Column(
        children: [
          Flexible(
            child: Image.asset(
              'assets/fondo_login.jpg',
              height: 350.0,
            ),
          ),
          const SizedBox(height: 15.0),
          _bottonPerfil(),
          const SizedBox(height: 20.0),
          _bottonContrasena(),
          const SizedBox(height: 20.0),
          _bottonCobro(),
        ],
      )),
=======
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
      ),
      //body: BarraNavegacion(),
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
>>>>>>> main
    );
  }

  // ignore: unused_element
  Widget _bottonPerfil() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/PerfilScreen');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: const Text(
            'Perfil',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
        ),
        //style: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
      );
    });
  }

  Widget _bottonContrasena() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/ContrasenaScreen');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: const Text(
            'Contraseña',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
        ),
        //style: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
      );
    });
  }

  Widget _bottonCobro() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/PagoScreen');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: const Text(
            'Cobro',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
        ),
        //style: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
      );
    });
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
