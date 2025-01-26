import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:one_device_auth/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'device_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DeviceService _deviceService = DeviceService();

  Future<UserModel?> loginOrRedirect() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return await checkAndUpdateDeviceStatus(currentUser);
    }
    return null;
  }

  Future<UserModel?> checkAndUpdateDeviceStatus(User user) async {
    String deviceId = await _deviceService.getDeviceId();

    DocumentSnapshot userDoc = await _firestore
        .collection('users')
        .doc(user.uid)
        .get();

    UserModel userModel = UserModel.fromFirestore(userDoc);

    if (!userModel.activeDevices.contains(deviceId)) {
      userModel.activeDevices = [deviceId];

      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({'activeDevices': userModel.activeDevices});

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      return userModel;
    }

    return userModel;
  }

  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String phoneNumber
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      String deviceId = await _deviceService.getDeviceId();

      UserModel userModel = UserModel(
          id: credential.user!.uid,
          email: email,
          phoneNumber: phoneNumber,
          activeDevices: [deviceId]
      );

      await _firestore.collection('users').doc(credential.user!.uid).set(
          userModel.toMap()
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      return userModel;
    } catch (e) {
      print('Signup error: $e');
      return null;
    }
  }

  Future<UserModel?> login({
    required String email,
    required String password
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      return await checkAndUpdateDeviceStatus(credential.user!);
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<bool> checkDeviceAuthorization() async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) return false;

    String currentDeviceId = await _deviceService.getDeviceId();

    DocumentSnapshot userDoc = await _firestore
        .collection('users')
        .doc(currentUser.uid)
        .get();

    UserModel userModel = UserModel.fromFirestore(userDoc);

    return userModel.activeDevices.contains(currentDeviceId);
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await _auth.signOut();
  }
}