import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth_service.dart';
import 'home.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MainScreen()));
}



class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = true;
  bool _isAuthorized = false;

  @override
  void initState() {
    super.initState();
    _checkDeviceStatus();
  }

  Future<void> _checkDeviceStatus() async {
    try {
      // This will automatically update device status
      await _authService.checkAndUpdateDeviceStatus;

      // Check if current device is authorized
      bool authorized = await _authService.checkDeviceAuthorization();

      setState(() {
        _isLoading = false;
        _isAuthorized = authorized;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isAuthorized = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return _isAuthorized ? HomeScreen() : LoginScreen();
  }
}