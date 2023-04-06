
import 'package:chats/const/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class ChatController extends GetxController {

 
   @override
    void onInit(){
        getChatId();
      super.onInit();
    }

    var firendName = Get.arguments[0];
    var firendId = Get.arguments[1];
 
    // var senderName = Get.find<HomeController>().userName;
    var senderName = "senderName";
    var currentId  = currentUser!.uid;

    var isLoading = false.obs;
    
    dynamic chatDocId;

    var msgController = TextEditingController();
  
    var chats = firestore.collection(chatsCollection);

  getChatId()async{
    isLoading(true);
    await chats.where('users',isEqualTo:{firendId:null,currentId:null}).limit(1).get().then((QuerySnapshot snapshot) {
      if(snapshot.docs.isNotEmpty){
        chatDocId = snapshot.docs.single.id;
      }else{
        chats.add({
          "created_on" : null,
          "last_msg" : "",
          "users" : {firendId:null,currentId:null},
          "toID" : '',
          "formId" : '',
          "frind_Name" : firendName,
          "sender_name" : senderName
        }).then((value){
          {
            chatDocId=value.id;
          }
        });
      }
    });
    isLoading(false);
 }

 SendMsg(String msg)async{
  if(msg.trim().isNotEmpty){
    chats.doc(chatDocId).update(
      {
        "created_on":FieldValue.serverTimestamp(),
        "last_msg" : msg,
        "toID" : firendId,
        "formId" : currentId
      }
    );


    chats.doc(chatDocId).collection(messagesCollection).doc().set({
        "created_on":FieldValue.serverTimestamp(),
        "msg" : msg,
        "uid" :currentId,
    });
  }
 }



}