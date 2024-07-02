// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:chat_app/services/auth.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controller/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const LoginPage());
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = Get.put(AuthController());
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signIn() async {
    authController.signIn(_emailController, _passwordController);
    // setState(() {
    //   _isLoading = true;
    // });
    // try {
    //   await supabase.auth.signInWithPassword(
    //     email: _emailController.text,
    //     password: _passwordController.text,
    //   );
    //   Navigator.of(context)
    //       .pushAndRemoveUntil(ChatPage.route(), (route) => false);
    // } on AuthException catch (error) {
    //   context.showErrorSnackBar(message: error.message);
    // } catch (_) {
    //   context.showErrorSnackBar(message: unexpectedErrorMessage);
    // }
    // if (mounted) {
    //   setState(() {
    //     _isLoading = true;
    //   });
    // }
  }

  Future<void> _signInwithgoogle() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId:
            '696753882900-fguh5fui1a6cvoo5qjfncaq50pjfs95l.apps.googleusercontent.com',
      );
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      Navigator.of(context)
          .pushAndRemoveUntil(ChatPage.route(), (route) => false);
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (_) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: ListView(
        padding: formPadding,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          formSpacer,
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          formSpacer,
          ElevatedButton(
            onPressed: _isLoading ? null : _signIn,
            child: const Text('Login'),
          ),
          GestureDetector(
            onTap: _isLoading ? null : _signInwithgoogle,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white54),
              // height: 60,
              // width: 30,
              child: Image.asset(
                'asset/google.png',
                height: 40,
                width: 30,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
