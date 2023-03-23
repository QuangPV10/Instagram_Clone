import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/src/resources/auth_methods.dart';
import 'package:instagram_clone/src/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/src/responsive/responsive_layout.dart';
import 'package:instagram_clone/src/responsive/web_screen_layout.dart';
import 'package:instagram_clone/src/share/constant.dart';
import 'package:instagram_clone/src/utils/utils.dart';
import 'package:instagram_clone/src/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? image;
  bool isLoading = false;
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
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        image != null
                            ? Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: MemoryImage(image!), fit: BoxFit.cover)),
                              )
                            : Container(
                                height: 120,
                                width: 120,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage('https://i.stack.imgur.com/l60Hf.png'), fit: BoxFit.cover)),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 70,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(
                              Icons.add_a_photo,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 18),
                    TextFieldInput(
                        hintText: 'Enter your User Name',
                        textEditingController: _usernameController,
                        textInputType: TextInputType.text),
                    const SizedBox(height: 15),
                    TextFieldInput(
                        hintText: 'Enter your Email',
                        textEditingController: _emailController,
                        textInputType: TextInputType.emailAddress),
                    const SizedBox(height: 15),
                    TextFieldInput(
                      hintText: 'Enter your Password',
                      textEditingController: _passwordController,
                      textInputType: TextInputType.text,
                      isPass: true,
                    ),
                    const SizedBox(height: 15),
                    TextFieldInput(
                        hintText: 'Enter your Bio',
                        textEditingController: _bioController,
                        textInputType: TextInputType.text),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(),
                          onPressed: signupUser,
                          child: isLoading
                              ? const Center(
                                  child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ))
                              : const Text('Sign Up')),
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
                      "Already have an account?",
                    ),
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Log In',
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

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }

  void signupUser() async {
    setState(() {
      isLoading = true;
    });

    final res = await AuthMethod().signUpUser(
        username: _usernameController.text,
        file: image!,
        email: _emailController.text,
        password: _passwordController.text,
        bio: _bioController.text);

    if (res != 'success') {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            const ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout()),
      ));
    }

    setState(() {
      isLoading = false;
    });

    clearEditTextingController();
  }

  void clearEditTextingController() {
    _bioController.clear();
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
    image = null;
  }

  @override
  void dispose() {
    super.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
