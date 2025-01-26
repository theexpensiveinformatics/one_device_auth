import 'package:flutter/material.dart';
import 'package:one_device_auth/signup.dart';
import 'package:one_device_auth/user_model.dart';

import 'auth_service.dart';
import 'home.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
  }

  void _checkAutoLogin() async {
    setState(() => _isLoading = true);
    bool isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn) {
      UserModel? user = await _authService.loginOrRedirect();
      if (user != null && mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen())
        );
      }
    }
    if (mounted) setState(() => _isLoading = false);
  }

  void _login() async {
    setState(() => _isLoading = true);
    UserModel? user = await _authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim()
    );

    if (mounted) {
      setState(() => _isLoading = false);
      if (user != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen())
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed. Please check your credentials.'))
        );
      }
    }
  }

  void _navigateToSignup() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignupScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder()
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder()
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50)
              ),
            ),
            TextButton(
              onPressed: _navigateToSignup,
              child: Text('Create an Account'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}