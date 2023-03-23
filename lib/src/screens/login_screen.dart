import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/src/resources/auth_methods.dart';
import 'package:instagram_clone/src/screens/sign_up_screen.dart';
import 'package:instagram_clone/src/share/constant.dart';
import 'package:instagram_clone/src/utils/utils.dart';
import 'package:instagram_clone/src/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void loginUser() async {
    String res = await AuthMethod().signInUser(email: _emailController.text, password: _passwordController.text);

    if (res != 'success') {
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 65,
                alignment: Alignment.center,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldInput(
                        hintText: 'Enter your Email',
                        textEditingController: _emailController,
                        textInputType: TextInputType.emailAddress),
                    const SizedBox(height: 25),
                    TextFieldInput(
                      hintText: 'Enter your Password',
                      textEditingController: _passwordController,
                      textInputType: TextInputType.text,
                      isPass: true,
                    ),
                    const SizedBox(height: 25),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(), onPressed: loginUser, child: const Text('Log In')),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                    ),
                    TextButton(
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            )),
                        child: const Text(
                          'Sign Up',
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
