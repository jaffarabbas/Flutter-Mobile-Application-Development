// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jz_instagram_app/resources/auth_methods.dart';
import 'package:jz_instagram_app/screens/login_screen.dart';
import 'package:jz_instagram_app/utils/colors.dart';
import 'package:jz_instagram_app/utils/utils.dart';
import 'package:jz_instagram_app/widgets/text_feild_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  //set loading
  void SetLoading(bool loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  //clear text feilds
  void ClearTextFeilds() {
    _emailController.clear();
    _passwordController.clear();
    _bioController.clear();
    _usernameController.clear();
    image = null;
  }

  //select image from gallery
  void SelectImageFormGallery() async {
    Uint8List file = await PickImage(ImageSource.gallery);
    setState(() {
      image = file;
    });
  }

  //Signup caller function to get
  void SignUpUser() async {
    SetLoading(true);
    String response = await AuthMethods().SignUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: image!,
    );
    SetLoading(false);
    if (response != 'success') {
      ShowSnakBar(response, context);
      ClearTextFeilds();
    } else {
      NavigatorToScreen(
        context,
        const ResponsiveLayout(
          WebScreenLayout: WebScreenLayout(),
          MobileScreenLayout: MobileScreenLayout(),
        ),
        1
      );
    }
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
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: primaryColor,
                  height: 64,
                ),
                const SizedBox(
                  height: 24,
                ),
                Stack(
                  children: [
                    image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(image!),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                              'https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-photo-183042379.jpg',
                            ),
                          ),
                    Positioned(
                      bottom: 5,
                      left: 80,
                      child: IconButton(
                        onPressed: SelectImageFormGallery,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                      height: 24,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 44,
                ),
                TextFeildInput(
                  textEditingController: _usernameController,
                  hintText: 'Enter your Username',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 24,
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
                TextFeildInput(
                  textEditingController: _bioController,
                  hintText: 'Enter your Bio',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: SignUpUser,
                  child: Container(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text('Sign Up'),
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
                  height: 12,
                ),
                // Flexible(
                //   child: Container(),
                //   flex: 2,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("have an account?"),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                      onTap: () => NavigatorToScreen(
                        context,
                        const LoginScreen(),
                        0
                      ),
                      child: Container(
                        child: const Text(
                          "Login In.",
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
