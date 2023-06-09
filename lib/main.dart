import 'package:chats/screens/register/Login/components/login_form.dart';
import 'package:chats/screens/register/Login/login_screen.dart';
import 'package:chats/screens/all_user.dart';
import 'package:chats/screens/chat_screen.dart';
//import 'package:chats/screens/register_foam.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main()async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData( 
        primarySwatch: Colors.blue,
      ),
      home:const LoginScreen(),
    );
  }
}


