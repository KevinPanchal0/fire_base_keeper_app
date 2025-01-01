import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_keeper_app/models/fire_store_model.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static final FireStoreHelper fsHelper = FireStoreHelper._();
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addUsers({required FireStoreModel fsModel}) async {
    bool isUserExists = false;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('users').get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
        querySnapshot.docs;

    allDocs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      String email = doc.data()['email'];

      if (email == fsModel.email) {
        isUserExists = true;
      }
    });

    if (isUserExists == false) {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await firebaseFirestore.collection('records').doc('users').get();
      int id = documentSnapshot['id'];
      int counter = documentSnapshot['counter'];

      id++;
      await firebaseFirestore.collection('users').doc('User_$id').set({
        'email': fsModel.email,
        'timestamp': fsModel.timestamp,
      });

      await firebaseFirestore.collection('records').doc('users').update(
        {
          'id': id,
          'counter': ++counter,
        },
      );
    }
  }

  //fetch all users
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllUsers() {
    return firebaseFirestore.collection('users').snapshots();
  }
}
