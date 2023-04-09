import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../const/firebase_const.dart';
import '../../../../controller/auth_controller.dart';
import '../../../all_user.dart';
import '../../Login/login_screen.dart';
import '../../components/already_have_an_account_acheck.dart';
import '../../constants.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    var controller = Get.put(AuthController());
    var emailContriller = TextEditingController();
    var passController = TextEditingController();
    var nameController = TextEditingController();
     
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your name",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: emailContriller,
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your Email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: passController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async{
              try {
                  await controller.signupMethod(
                    context: context,
                    email: emailContriller.text,
                    password: passController.text
                    ).then((value){
                    return controller.storeUserDate(
                      email: emailContriller.text,
                      name: nameController.text
                      ).then((value){
                      VxToast.show(context, msg: "loggedin");
                      Get.offAll(const AllUser());
                    });
                  });
                } catch (e) {
                  VxToast.show(context, msg: "loggedout");
                  auth.signOut();
                  
                }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}