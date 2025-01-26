import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String phoneNumber;
  List<String> activeDevices;

  UserModel({
    required this.id,
    required this.email,
    required this.phoneNumber,
    this.activeDevices = const [],
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'],
      phoneNumber: data['phoneNumber'],
      activeDevices: List<String>.from(data['activeDevices'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phoneNumber': phoneNumber,
      'activeDevices': activeDevices,
    };
  }
}