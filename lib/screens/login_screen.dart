import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res == 'success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreen(),
            webScreenLayout: WebScreen(),
          ),
        ),
      );
    } else {
      showSnackBar(context, '');
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              SvgPicture.asset(
                './assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),

              // Email Controller
              TextFieldInput(
                textEditingController: _emailController,
                hintText: "Enter your email",
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                isPass: true,
                hintText: "Enter your password",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),

              InkWell(
                onTap: loginUser,
                child: Container(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        )
                      : const Text('Log in'),
                  width: double.infinity,
                  height: 55,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // transition to signin up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text('Don\'t have an account?'),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                    onTap: navigateToSignUp,
                    child: Text(
                      'Sign up',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
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
