import 'package:chats/controller/auth_controller.dart';
import 'package:chats/screens/all_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../const/firebase_const.dart';

class RegisterFoam extends StatelessWidget {
  const RegisterFoam({super.key});

  @override
  Widget build(BuildContext context) {

  
  var controller = Get.put(AuthController());

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
               TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: "Email"),
                ),
                const SizedBox(height: 20,),
                 TextFormField(
                  controller:controller.passwordController ,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: "type a messege ..."),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed:()async{
                      await controller.loginMethod(context: context,).then((value){
                            if(value !=null){
                              Get.offAll(const AllUser());
                              VxToast.show(context, msg: "loggedin");
                            }else{
                              Get.to(const RegisterFoam());
                              VxToast.show(context, msg: "logged in error");
                            }
                          });
                    } , child:const Text("Login")),
                    const SizedBox(width: 10,),
                    ElevatedButton(onPressed: ()async{
                      try {
                            await controller.signupMethod(context: context).then((value){
                              return controller.storeUserDate().then((value){
                                VxToast.show(context, msg: "loggedin");
                                Get.offAll(const AllUser());
                              });
                            });
                          } catch (e) {
                            VxToast.show(context, msg: "loggedout");
                            auth.signOut();
                            
                          }
                    }, child:const Text('signup'))
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}