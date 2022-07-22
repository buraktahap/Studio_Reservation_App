// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthenticationProvider {
//   final FirebaseAuth firebaseAuth;
//   //FirebaseAuth instance
//   AuthenticationProvider(this.firebaseAuth);
//   //Constuctor to initalize the FirebaseAuth instance

//   //Using Stream to listen to Authentication State
//   Stream<User?> get authState => firebaseAuth.idTokenChanges();

//   //............RUDIMENTARY METHODS FOR AUTHENTICATION................

//   //SIGN UP METHOD
//   Future<String> signUp(
//       {required String email, required String password}) async {
//     try {
//       await firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return "Kayıt olundu!";
//     } on FirebaseAuthException catch (e) {
//       return e.message!;
//     }
//   }

//   //SIGN IN METHOD
//   Future<String> signIn(
//       String email, String password, BuildContext context) async {
//     try {
//       await firebaseAuth.signInWithEmailAndPassword(
//           email: email, password: password);
//       SnackBar snackBar = SnackBar(
//         content: Text("Giriş Yapıldı."),
//         elevation: 5,
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: Colors.green[400],
//         padding: EdgeInsets.all(10),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);

//       return "Oturum Açıldı!";
//     } on FirebaseAuthException catch (e) {
//       SnackBar snackBar = SnackBar(
//         content: Text("Hatalı Email ya da Şifre."),
//         elevation: 5,
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: Colors.red[400],
//         padding: EdgeInsets.all(10),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       return e.message!;
//     }
//   }

//   //SIGN OUT METHOD
//   Future<void> signOut(BuildContext context) async {
//     await firebaseAuth.signOut();
//     SnackBar snackBar = SnackBar(
//       content: Text("Çıkış yapıldı."),
//       elevation: 5,
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.red[400],
//       padding: EdgeInsets.all(10),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
