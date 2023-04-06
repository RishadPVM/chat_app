import 'package:chats/controller/chat_controller.dart';
import 'package:chats/services/firestore_services.dart';
import 'package:chats/widget/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as int1;
import 'package:velocity_x/velocity_x.dart';

import '../const/firebase_const.dart';

class chat_screen extends StatelessWidget {
  final String firendName;
  //String firenId;
  const chat_screen({super.key, required this.firendName});

  @override
  Widget build(BuildContext context) {

    final ScrollController _chatController = ScrollController();
    var controller = Get.put(ChatController());

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(firendName),
      ),
      body: Column(
        children: [
           Obx(
              ()=>
          controller.isLoading.value
          ? Center(child:loadingIndicator(),)
          : Expanded(
                child:StreamBuilder(
                              stream: FirestorServices.getChatMessage(
                    controller.chatDocId.toString()),
                              builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: loadingIndicator());
                  } else if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text(
                      "Send a message ...",
                      style: TextStyle(color: Color.fromARGB(255, 70, 68, 68)),
                    ));
                  } else {

                    return ListView(
                      controller: _chatController,
                      children:snapshot.data!.docs.mapIndexed((currentValue, index) {
                        var data = snapshot.data!.docs[index];

                            
                        //list update
                       Future.delayed(const Duration(milliseconds: 150));
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                     _chatController.animateTo(
                       _chatController.position.maxScrollExtent,
                       duration: Duration(milliseconds: 500),
                       curve: Curves.fastOutSlowIn);
                     });
                        

                      var t= data['created_on']==null ? DateTime.now() : data['created_on'].toDate();
                      var time = int1.DateFormat("h:mma").format(t);


                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: data['uid'] == currentUser!.uid
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Directionality(
                              textDirection: data['uid'] == currentUser!.uid ?TextDirection.rtl:TextDirection.ltr,
                              child: Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Colors.cyan,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      " ${data['msg']} ".text.size(16).color(Colors.white).make(),
                                     time.text.color(Colors.white.withOpacity(0.8)).make()
                                    ],
                                  )),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                              },
                            ),
                ),
           ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                      child: TextFormField(
                    controller: controller.msgController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        hintText: "type a messege ..."),
                  )),
                
                IconButton(
                    onPressed: () {
                      controller.SendMsg(controller.msgController.text);
                      controller.msgController.clear(); 

                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.cyan,
                    ))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
