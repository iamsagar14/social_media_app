import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/res/color.dart';
import 'package:social_media_app/utils/routes/route_name.dart';
import 'package:social_media_app/utils/utlis.dart';
import 'package:social_media_app/view_model/signup/signup_controller.dart';

import '../../res/components/input_text_field.dart';
import '../../res/components/round_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameFocusNode = FocusNode();
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
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: ChangeNotifierProvider(
              create: (context) => SignUpController(),
              child: Consumer<SignUpController>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
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
                          height: height * .02,
                        ),
                        Text(
                          'Enter your Email address \n to register your account  ',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.lightBlue),
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
                                  myController: userNameController,
                                  focusNode: userNameFocusNode,
                                  onFieldSubmittedValue: (value) {},
                                  onValidator: (value) {
                                    return value.isEmpty
                                        ? 'Enter username'
                                        : null;
                                  },
                                  keyBoardType: TextInputType.emailAddress,
                                  hint: 'Enter username',
                                  obscureText: false,
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                InputTextField(
                                  myController: emailController,
                                  focusNode: emailFocusNode,
                                  onFieldSubmittedValue: (value) {
                                    Utils.fieldFocus(context, emailFocusNode,
                                        passwordFocusNode);
                                  },
                                  onValidator: (value) {
                                    return value.isEmpty ? 'Enter email' : null;
                                  },
                                  keyBoardType: TextInputType.emailAddress,
                                  hint: 'Enter email',
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
                                    return value.isEmpty
                                        ? 'Enter password  '
                                        : null;
                                  },
                                  keyBoardType: TextInputType.emailAddress,
                                  hint: 'Enter password',
                                  obscureText: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        RoundButton(
                          title: 'sign up',
                          loading: provider.loading,
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              provider.signUp(
                                  context,
                                  userNameController.text,
                                  emailController.text,
                                  passwordController.text);
                            }
                          },
                        ),
                        SizedBox(
                          height: height * .03,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.loginView);
                          },
                          child: Text.rich(
                            TextSpan(
                                text: "Already have an account ? ",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(fontSize: 15),
                                children: [
                                  TextSpan(
                                    text: "Login",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2!
                                        .copyWith(
                                            color: AppColors.lightBlue,
                                            fontSize: 20,
                                            decoration:
                                                TextDecoration.underline),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}
