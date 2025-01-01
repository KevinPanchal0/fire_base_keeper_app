import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreModel {
  String email;
  FieldValue timestamp;

  FireStoreModel({required this.email, required this.timestamp});
}
