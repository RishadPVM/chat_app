import 'package:chats/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:velocity_x/velocity_x.dart';

import '../services/firestore_services.dart';
import '../widget/loading.dart';

class AllUser extends StatelessWidget {
  const AllUser({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.cyan ,
        appBar: AppBar(
    //      systemOverlayStyle: SystemUiOverlayStyle(
  //   statusBarColor: Colors.green, // <-- SEE HERE
  //   //statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
  //   //statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
  // ),
          elevation: 0,
          backgroundColor:Colors.transparent,//Color.fromARGB(255, 253, 250, 250)
          title: const Text("Chat-X",),
          actions:const [
            Padding(
              padding:EdgeInsets.only(right:10.0),
              child: Icon(Icons.search,size: 30,),
            )
            ],
        ),
          
        body: Padding(
          padding: const EdgeInsets.only(top:30.0),
          child: StreamBuilder(
            stream: FirestorServices.getAllUser(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: loadingIndicator());
                } else if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text(
                    "user not available",
                    style: TextStyle(color: Color.fromARGB(255, 70, 68, 68)),
                  ));
                }else{
                  
                       var data = snapshot.data!.docs;
                    return ListView.builder(
                      
                     itemCount: data.length,
                     itemBuilder:(context, index) {
                      
                      return ListTile(
                        title: Text(data[index]['name'],
                        style:const TextStyle(
                         color: Colors.black,
                         fontSize: 20
                         ),),
                         leading: const CircleAvatar(
                           radius: 25,
                           backgroundColor: Color.fromARGB(255, 236, 233, 233),
                           child: Icon(Icons.person,size: 30,),
                         ),
                         subtitle: Text('last messesge...'),
                         trailing: Text("10:15"),
                        onTap: () {
                          Get.to(
                           chat_screen(firendName:data[index]['name']),
                           arguments: [data[index]['email'],data[index]['id']]
                          );
                          
                        },
                      );
                     },
                     );
                         }
                     },
            ),
        ).box.color(Colors.white).topRounded(value: 50).make()
      ),
    );
  }
}

