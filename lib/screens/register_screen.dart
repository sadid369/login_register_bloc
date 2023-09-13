import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:login_register_bloc/bloc/register_bloc.dart';
import 'package:login_register_bloc/screens/login_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey _formState = GlobalKey<FormState>();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);
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
                  'Register',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                StreamBuilder<String>(
                    stream: bloc.email,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: (value) => bloc.changeEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Enter Email",
                            label: const Text('Email'),
                            errorText: snapshot.error.toString(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      );
                    }),
                const SizedBox(
                  height: 30,
                ),
                StreamBuilder<String>(
                    stream: bloc.name,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.text,
                        onChanged: (value) => bloc.changeName,
                        decoration: InputDecoration(
                            hintText: "Enter Name",
                            label: const Text('Name'),
                            errorText: snapshot.error.toString(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      );
                    }),
                const SizedBox(
                  height: 30,
                ),
                StreamBuilder<String>(
                    stream: bloc.phoneNumber,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: (value) => bloc.changePhoneNumber,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "Enter Phone Number",
                            label: const Text('Phone Number'),
                            errorText: snapshot.error.toString(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      );
                    }),
                const SizedBox(
                  height: 30,
                ),
                StreamBuilder<String>(
                    stream: bloc.password,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: (value) => bloc.changePassword,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          label: const Text('Password'),
                          errorText: snapshot.error.toString(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              )),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 30,
                ),
                StreamBuilder<String>(
                    stream: bloc.confirmPassword,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: (value) => bloc.changeConfirmPassword,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          label: const Text('Confirm Password'),
                          errorText: snapshot.error.toString(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              )),
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
                        text: "Already have an account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      const WidgetSpan(
                          child: SizedBox(
                        width: 5,
                      )),
                      TextSpan(
                          text: 'Login here',
                          style: const TextStyle(color: Colors.black),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) {
                                  return const LoginScreen();
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
    final bloc = Provider.of<RegisterBloc>(context, listen: false);
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
                'Register',
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
