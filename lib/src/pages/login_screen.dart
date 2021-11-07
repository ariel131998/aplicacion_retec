import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  //static String id = 'login_page '; // ver si me va a servir
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   //title: const Text('Login retec'),
      //   title: Image.asset('assets/fondo_login.jpg', fit: BoxFit.cover)
      // ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: Image.asset(
                'assets/fondo_login.jpg',
                height: 350.0,
              ),
            ),
            SizedBox(height: 15.0),
            userTextField(),
            SizedBox(height: 20.0),
            passwordTextField(),
            SizedBox(height: 15.0),
            _bottonLogin(),
            SizedBox(height: 15.0),
            _TextRecuperarCont(),
            
          ],
        )
      ),
    );
  }


Widget userTextField() {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon(Icons.email),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo electronico',
          ),
          onChanged: (email){// se guarda el email ingresado

          },
        ),
      );
    }  
  );

}

Widget passwordTextField() {
  return StreamBuilder(
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            hintText: 'Contraseña',
            labelText: 'Contraseña',
          ),
          onChanged: (contrasena){// se guarda el email ingresado

          },
        ),
      );
    }  
  );
}


 Widget _bottonLogin() {
  return StreamBuilder(
     builder: (BuildContext context, AsyncSnapshot snapshot){
       return ElevatedButton(
         onPressed: (){
           Navigator.of(context).pushNamed('/ClienteScreen');
         }, 
         child: Container(
           padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
           child: Text(
             'Iniciar Sesion', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
         ),
         //style: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
      );
     }
  );
 }

  Widget _TextRecuperarCont() {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return TextButton(
          onPressed:(){

          }, 
          child: Text('Recuperar contraseña'),
        );
      }
    );
  }


  
}




// onPressed: () {
//             Navigator.of(context).pushNamed('/ClienteScreen');