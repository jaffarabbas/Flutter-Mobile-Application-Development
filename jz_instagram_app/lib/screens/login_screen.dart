// ignore_for_file: unused_field, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jz_instagram_app/resources/auth_methods.dart';
import 'package:jz_instagram_app/screens/signup_screen.dart';
import 'package:jz_instagram_app/utils/colors.dart';
import 'package:jz_instagram_app/widgets/text_feild_input.dart';

import '../utils/utils.dart';

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

  //clear text feilds
  void ClearTextFeilds() {
    _emailController.clear();
    _passwordController.clear();
  }

  //set loading
  void SetLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  void LoginUser() async {
    SetLoading(true);
    String response = await AuthMethods().LoginInUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (response != 'success') {
      ShowSnakBar(response, context);
      ClearTextFeilds();
    }
    SetLoading(false);
  }

  //navigate to SignUp
  void NavigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Flexible(
                //   child: Container(),
                //   flex: 2,
                // ),
                const SizedBox(
                  height: 94,
                ),
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(
                  height: 64,
                ),
                TextFeildInput(
                  textEditingController: _emailController,
                  hintText: 'Enter your Email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFeildInput(
                  textEditingController: _passwordController,
                  hintText: 'Enter your Password',
                  textInputType: TextInputType.text,
                  isPassword: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: LoginUser,
                  child: Container(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text('Login in'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 160,
                ),
                // Flexible(
                //   child: Container(),
                //   flex: 2,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("Dont't have an account?"),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: NavigateToSignUp,
                      child: Container(
                        child: const Text(
                          "Sign up.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
