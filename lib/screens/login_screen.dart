import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:login_register_bloc/bloc/login_bloc.dart';
import 'package:login_register_bloc/screens/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey _formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return Scaffold(
      body: Form(
        key: _formState,
        child: Container(
          alignment: Alignment.center,
          color: const Color(0xffc2e2f9),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                StreamBuilder<String>(
                    stream: bloc.loginEmail,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => bloc.changeLoginEmail,
                        decoration: InputDecoration(
                            hintText: "Enter Email",
                            label: const Text('Email'),
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      );
                    }),
                const SizedBox(
                  height: 30,
                ),
                StreamBuilder<String>(
                    stream: bloc.loginPassword,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => bloc.changePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          label: const Text('Password'),
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 30,
                ),
                _buildButton(),
                const SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Need an Account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      const WidgetSpan(
                          child: SizedBox(
                        width: 5,
                      )),
                      TextSpan(
                          text: 'Register here',
                          style: const TextStyle(color: Colors.black),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) {
                                  return const RegisterScreen();
                                },
                              ));
                            })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return StreamBuilder<Object>(
        stream: bloc.isValid,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: snapshot.hasError || !snapshot.hasData
                ? null
                : () {
                    bloc.submit();
                  },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                color: snapshot.hasError || !snapshot.hasData
                    ? Colors.grey
                    : const Color(0xffff69b4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        });
  }
}
