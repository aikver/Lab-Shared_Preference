import 'package:flutter/material.dart';
import 'package:flutterr/controller/auth_service.dart';
import 'package:flutterr/formlogin/regiter.dart';
import 'package:flutterr/pages/home.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String _errorMessage = "";
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      print('Username : ${_usernameController.text}');
      print('Password : ${_passwordController.text}');
      try {
        final user = await AuthService()
            .login(_usernameController.text, _passwordController.text);
      } catch (e) {
        print(e);
      }
    }
  }

  void saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userName", _usernameController.text);
    await prefs.setString("password", _passwordController.text);
  }

  String? userName;
  String? password;

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString("userName");
      password = prefs.getString("password");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4facfe),
                  Color(0xFF00f2fe),
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Welcome text with animation
                    FadeTransition(
                      opacity: _animation,
                      child: const Text(
                        'WELCOME',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black45,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Animated icon
                    ScaleTransition(
                      scale: _animation,
                      child: const Icon(
                        Icons.sailing,
                        color: Colors.white,
                        size: 120,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Input fields container with some stylish decoration
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              labelText: 'Username',
                              labelStyle: const TextStyle(color: Colors.cyan),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.cyan,
                              ),
                              filled: true,
                              fillColor: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.cyan),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.cyan,
                              ),
                              filled: true,
                              fillColor: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Login button with ripple effect
                    ElevatedButton(
                      onPressed: () {
                        if (_usernameController.text.trim().isNotEmpty &&
                            _passwordController.text.trim().isNotEmpty) {
                          saveData();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(
                                title: 'HomePage',
                              ),
                            ),
                          );
                        } else {
                          if (_usernameController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please enter your username")),
                            );
                          }
                          if (_passwordController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please enter your password")),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.cyan,
                        shadowColor: Colors.cyanAccent,
                        elevation: 10,
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                      child: const Text(
                        'Create an account',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.cyan,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
