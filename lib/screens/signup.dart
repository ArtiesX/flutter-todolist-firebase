import 'package:flutter/material.dart';
import 'package:flutter_todolist_firebase/services/auth_services.dart';
import 'package:flutter_todolist_firebase/utils/style.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _displaynameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildUserField(),
              const SizedBox(height: 20),
              buildEmailField(),
              const SizedBox(height: 20),
              buildPasswordField(),
              const SizedBox(height: 20),
              buildConfirmField(),
              const SizedBox(height: 20),
              buildButton(),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildUserField() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[100]),
      child: TextField(
        controller: _displaynameController,
        autofocus: true,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration.collapsed(hintText: 'Username'),
      ),
    );
  }

  Widget buildEmailField() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[100]),
      child: TextField(
        controller: _emailController,
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
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration.collapsed(hintText: 'Password'),
      ),
    );
  }

  Widget buildConfirmField() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[100]),
      child: TextField(
        controller: _confirmController,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration.collapsed(hintText: 'Re-Password'),
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
              _passwordController.text.isNotEmpty &&
              _displaynameController.text.isNotEmpty &&
              _confirmController.text.isNotEmpty) {
            if (_passwordController.text == _confirmController.text) {
              await AuthService()
                  .signUp(
                      name: _displaynameController.text.trim(),
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim())
                  .then((value) => {
                        print('Sign Up Sucessful'),
                        Navigator.pop(context),
                      });
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: errorColor,
                behavior: SnackBarBehavior.floating,
                content: Text("Input is not valid")));
          }
        },
        child: const Center(
          child: Text(
            'Create Account',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
