import 'package:chats/const/firebase_const.dart';

class FirestorServices {


// get user login data 
  static getUser(uid){
    return firestore.collection(userCollection).where('id',isEqualTo: uid).snapshots();
  }

  //get all messagess
  static getChatMessage(docId){
    return firestore.collection(chatsCollection).doc(docId).collection(messagesCollection).orderBy('created_on',descending: false).snapshots();
 }

 // get all user
 static getAllUser(){
    return firestore.collection(userCollection).where('name').snapshots();
 }

}