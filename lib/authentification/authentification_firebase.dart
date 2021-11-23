import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
//En esta clase vamos a poder monitorear el estado del usurio, si ya tiene iniciada sesion
//si ya cerro sesion o si se quiere crear o iniciar sesion.
class AuthentificationFirebase {
  final FirebaseAuth _firebaseAuth;
  AuthentificationFirebase(this._firebaseAuth);//constructor

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges(); //puse un ? checar para que sirve

  Future<void> singOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({required String email, required String password}) async{//iniciar sesion o ingresar
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return 'inicio sesion'; //checar si no es aqui donde debo mandar a la pagina principal??
      //return ClienteScreen2();
    } on FirebaseAuthException catch (e) {
      //errores._stringError = e.message.toString();
      //errores._stringError2 ='error';
      Fluttertoast.showToast(
        gravity: ToastGravity.TOP,
        msg: e.message.toString(),
      );
      return e.toString();
    }
  }
  Future<String> signUp({required String email, required String password}) async{//registrarse agrege el required
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(
        msg: "Usuario registrado correctamente",
        gravity: ToastGravity.TOP,
      );
      return 'se registro exitosamente'; //checar si no es aqui donde debo mandar a la pagina principal??
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        gravity: ToastGravity.TOP,
      );
      return e.message.toString();
    }
  }
}





//pruebas mensajes emergenes
// class MandarErrorLogin extends ChangeNotifier{
//   String _stringError;//login
//   String _stringError2;//solo saber que hay un error
//   MandarErrorLogin(this._stringError, this._stringError2);//constructor
  
//   String get errorLogIn{
//     return _stringError;
//   }

//   void set errorLogIn(String Error){
//     _stringError = Error;
//   }
//   String get errorLogIn2{
//     return _stringError2;
//   }

//   void set errorLogIn2(String Error){
//     _stringError2 = Error;
//   }


// }