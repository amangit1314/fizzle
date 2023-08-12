import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/services/firebase/auth/auth_methods.dart';
import '../../responsive/mobile_screen_layout.dart';
import '../../responsive/responsive_layout.dart';
import '../../responsive/web_screen_layout.dart';
import '../login/login_screen.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image ?? Uint8List(0),
    );

    if (res == "success") {
      setState(() {
        _isLoading = false;
      });

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return;
      showSnackBar(context, res);
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff051726),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              const Text(
                'Sociogram',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 55,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: const Color(0xff81ffd9),
                        )
                      : const CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          backgroundColor: Color(0xff81ffd9),
                        ),
                  Positioned(
                    bottom: -5,
                    left: 68,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xff051726),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            const Color(0xff051726).withOpacity(.7),
                        child: Center(
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const FaIcon(
                              FontAwesomeIcons.camera,
                              size: 18,
                              color: Color(0xff81ffd9),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              TextFieldInput(
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
                icon: const Icon(Icons.perm_identity, size: 18),
              ),
              const SizedBox(height: 20),
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
                icon: const Icon(Icons.alternate_email_outlined, size: 18),
              ),
              const SizedBox(height: 20),
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                icon: const Icon(Icons.fingerprint_outlined, size: 18),
                isPass: true,
                suffixIcon: const Icon(Icons.visibility),
              ),
              const SizedBox(height: 20),
              TextFieldInput(
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
                icon: const Icon(Icons.power_input_sharp, size: 18),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Color(0xff81ffd9), // Changed button color here
                  ),
                  child: !_isLoading
                      ? const Text(
                          'Register',
                          style: TextStyle(
                            color: Color(0xff051726),
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        ' Login',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff81ffd9), // Changed text color here
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
