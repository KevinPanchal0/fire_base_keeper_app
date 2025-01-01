import 'package:fire_base_keeper_app/utils/helpers/fb_auth_helper.dart';
import 'package:fire_base_keeper_app/utils/prefs/auth_preferences.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign IN"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  Map<String, dynamic> res = await FbAuthHelper.fbAuthHelper
                      .signIn(
                          email: emailController.text,
                          password: passwordController.text);

                  if (res['user'] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Sign IN Successfull...!"),
                        backgroundColor: Colors.green,
                      ),
                    );

                    emailController.clear();
                    passwordController.clear();
                    await AuthPreferences.saveLoginState(true);
                    Navigator.pushReplacementNamed(context, '/');
                  } else if (res['error'] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${res['error']}"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error Signing Up...!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: Text('Sign Up with Email'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text('Sign In with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
