import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:velocity_x/velocity_x.dart';

import '../const/firebase_const.dart';

class AuthController extends GetxController{

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
 
 //login
  Future<UserCredential?>loginMethod({context,email,pass})async{
    UserCredential? userCredential;
    try {
     userCredential = await auth.signInWithEmailAndPassword(email:emailController.text, password: passwordController.text);
    }on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
    return userCredential;
  }

  //signup
  Future<UserCredential?>signupMethod({email,password,context})async{
    UserCredential? userCredential;
    try {
     userCredential = await auth.createUserWithEmailAndPassword(email: emailController.text, password:passwordController.text);
    }on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing
  storeUserDate()async{
    DocumentReference store =await firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      'email': emailController.text,
      "id":currentUser!.uid,
    });
  }

  //sigout
  signoutMethod(context)async{
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

}