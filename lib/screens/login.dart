import 'package:flutter/material.dart';
import 'package:flutter_todolist_firebase/screens/signup.dart';
import 'package:flutter_todolist_firebase/services/auth_services.dart';
import 'package:flutter_todolist_firebase/utils/navbar.dart';

import '../utils/style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _emailController.text = "";
    _passwordController.text = "";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildEmailField(),
              const SizedBox(height: 20),
              buildPasswordField(),
              const SizedBox(height: 20),
              buildButton(),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
                      _emailController.text = "";
                      _passwordController.text = "";
                    },
                    child: const Text("You are haven't account?")),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget buildEmailField() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[100]),
      child: TextField(
        controller: _emailController,
        autofocus: true,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration.collapsed(hintText: 'Email'),
      ),
    );
  }

  Widget buildPasswordField() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[100]),
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration.collapsed(hintText: 'Password'),
      ),
    );
  }

  Widget buildButton() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: primaryColor,
      ),
      child: InkWell(
        onTap: () async {
          if (_emailController.text.isNotEmpty &&
              _passwordController.text.isNotEmpty) {
            await AuthService()
                .login(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim())
                .then((value) => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Navbar())));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: errorColor,
                behavior: SnackBarBehavior.floating,
                content: Text("Input is not valid")));
          }
        },
        child: const Center(
          child: Text(
            'Login',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
