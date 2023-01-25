import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signin;
  final GlobalKey _signUpFormKey = GlobalKey<FormState>();
  final GlobalKey _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            GlobalVariables.kVerticalSpaceTiny,
            ListTile(
              title: const Text('Create An Account'),
              tileColor: (_auth == Auth.signup)
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundColor,
              leading: Radio(
                groupValue: _auth,
                value: Auth.signup,
                onChanged: (value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signup)
              Container(
                padding: const EdgeInsets.all(8.0),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        text: 'Name',
                      ),
                      GlobalVariables.kVerticalSpaceSmall,
                      CustomTextField(
                        controller: _emailController,
                        text: 'Email',
                      ),
                      GlobalVariables.kVerticalSpaceSmall,
                      CustomTextField(
                        controller: _passwordController,
                        text: 'Password',
                        isPassword: true,
                      ),
                      GlobalVariables.kVerticalSpaceSmall,
                      CustomButton(
                        text: 'SignUp',
                        action: () {},
                      )
                    ],
                  ),
                ),
              ),
            ListTile(
              title: const Text('Sign-in.'),
              tileColor: (_auth == Auth.signin)
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundColor,
              leading: Radio(
                groupValue: _auth,
                value: Auth.signin,
                onChanged: (value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signin)
              Container(
                padding: const EdgeInsets.all(8.0),
                color: GlobalVariables.backgroundColor,
                child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          text: 'Email',
                        ),
                        GlobalVariables.kVerticalSpaceSmall,
                        CustomTextField(
                          controller: _passwordController,
                          text: 'Password',
                          isPassword: true,
                        ),
                        GlobalVariables.kVerticalSpaceSmall,
                        CustomButton(
                          text: 'Sign In',
                          action: () {},
                        )
                      ],
                    )),
              ),
          ],
        ),
      )),
    );
  }
}
