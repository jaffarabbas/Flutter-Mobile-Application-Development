import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotnet_web_api_integration/res/components/defaultButton.dart';
import 'package:flutter_dotnet_web_api_integration/utils/routes/routes_names.dart';
import 'package:flutter_dotnet_web_api_integration/utils/utils.dart';
import 'package:provider/provider.dart';
import '../view model/auth_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpView> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    _obscureText.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp"),
        automaticallyImplyLeading: false, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: firstNameController,
              keyboardType: TextInputType.name,
              focusNode: firstNameFocusNode,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: 'First Name',
              ),
              onFieldSubmitted: (feild) {
                Utils.feildFocusChange(
                    context, firstNameFocusNode, lastNameFocusNode);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Email',
              ),
              onFieldSubmitted: (feild) {
                Utils.feildFocusChange(
                    context, emailFocusNode, passwordFocusNode);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder(
              valueListenable: _obscureText,
              builder: (context, falg, child) {
                return TextFormField(
                  controller: passwordController,
                  obscureText: _obscureText.value,
                  focusNode: passwordFocusNode,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    suffixIcon: InkWell(
                      child: Icon(_obscureText.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility),
                      onTap: () {
                        _obscureText.value = !_obscureText.value;
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder(
              valueListenable: _obscureText,
              builder: (context, falg, child) {
                return TextFormField(
                  controller: confirmPasswordController,
                  obscureText: _obscureText.value,
                  focusNode: confirmPasswordFocusNode,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Confirm Password',
                    suffixIcon: InkWell(
                      child: Icon(_obscureText.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility),
                      onTap: () {
                        _obscureText.value = !_obscureText.value;
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            DefaultButton(title: 'Login', loading: authViewModel.authLoading, onPressed: (){
              if(emailController.text.isEmpty && passwordController.text.isEmpty){
                Utils.flushBarErrorMessage('Please Fill All Feilds', context);
              }else if(passwordController.text.length < 6){
                Utils.flushBarErrorMessage('Password Must Be 6 Characters', context);
              }else{  
                Map data = {
                  // 'email': emailController.text,
                  'email': 'eve.holt@reqres.in',
                  // 'password': passwordController.text
                  'password': 'cityslicka'
                };
                authViewModel.loginApi(data, context);
              }
            }),
            const SizedBox(
              height: 20,
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Have An Account?'),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.login);
                    },
                    child: Text('Login'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
