import 'package:get/get_state_manager/get_state_manager.dart';

import '../const/firebase_const.dart';

class HomeController extends GetxController {
   var userName = '' ;

   getUserName()async{
   var n=  await firestore.collection(userCollection).where('id',isEqualTo: currentUser!.uid).get().then((value) {
        if(value.docs.isNotEmpty){
          return value.docs.single['email'];
        }else{
          return 'invalid user';
        }
    });

    userName = n;
    
   }
}