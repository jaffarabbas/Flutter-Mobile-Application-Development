import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotnet_web_api_integration/res/components/defaultButton.dart';
import 'package:flutter_dotnet_web_api_integration/utils/routes/routes_names.dart';
import 'package:flutter_dotnet_web_api_integration/utils/utils.dart';
import 'package:provider/provider.dart';
import '../view model/auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> _obscureText = ValueNotifier<bool>(false);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obscureText.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              children: [
                Text('Don\'t Have An Account?'),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.signup);
                    },
                    child: Text('Sign Up'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
