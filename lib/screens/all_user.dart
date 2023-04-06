import 'package:chats/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../services/firestore_services.dart';
import '../widget/loading.dart';

class AllUser extends StatelessWidget {
  const AllUser({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("chat-X"),),
        
        body: StreamBuilder(
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
                    
                    return Card(
                     child: ListTile(
                       title: Center(
                         child: Text(data[index]['email'],
                         style:const TextStyle(
                          color: Colors.black,
                          fontSize: 20
                          ),),
                       ),
                       onTap: () {
                         Get.to(
                          chat_screen(firendName:data[index]['email']),
                          arguments: [data[index]['email'],data[index]['id']]
                         );
                         
                       },
                     ),
                    );
                   },
                   );
                       }
                   },
          )
      ),
    );
  }
}

