import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/login/login_controller.dart';

import '../../res/components/input_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  'Welcome TO APP ',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  'Enter your Email address \n to connect to your account  ',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: height * .06, bottom: height * 0.01),
                    child: Column(
                      children: [
                        InputTextField(
                          myController: emailController,
                          focusNode: emailFocusNode,
                          onFieldSubmittedValue: (value) {},
                          onValidator: (value) {
                            return value.isEmpty ? 'enter email' : null;
                          },
                          keyBoardType: TextInputType.emailAddress,
                          hint: 'Enter Email',
                          obscureText: false,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        InputTextField(
                          myController: passwordController,
                          focusNode: passwordFocusNode,
                          onFieldSubmittedValue: (value) {},
                          onValidator: (value) {
                            return value.isEmpty ? 'enter email' : null;
                          },
                          keyBoardType: TextInputType.emailAddress,
                          hint: 'Enter password',
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.forgotScreen);
                    },
                    child: Text(
                      "Forgot Password ?",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 15, decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                ChangeNotifierProvider(
                  create: (context) => LogInController(),
                  child: Consumer<LogInController>(
                    builder: (context, provider, child) {
                      return RoundButton(
                        title: 'login',
                        loading: provider.loading,
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            provider.logIN(context, emailController.text,
                                passwordController.text);
                          }
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.signupView);
                  },
                  child: Text.rich(
                    TextSpan(
                        text: "Don't have an account ? ",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 15),
                        children: [
                          TextSpan(
                            text: "SignUp",
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    fontSize: 15,
                                    decoration: TextDecoration.underline),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
