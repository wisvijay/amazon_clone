import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/constants/global_variables.dart';
import '/common/widgets/http_error_handling.dart';
import '/constants/utils.dart';
import '/models/user.dart';
import '/providers/user_provider.dart';

class AuthServices {
  //Signup User
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context,
                'Account created successfully! Please Login with the credentials');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //Signin User
  void signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final pref = await SharedPreferences.getInstance();

      http.Response response = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () async {
            Provider.of<UserProvider>(context, listen: false)
                .setUser(response.body);
            await pref.setString(
                GlobalVariables.tokenKey, json.decode(response.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, GlobalVariables.homeRouteName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //Get User
  void getUser(BuildContext context) async {
    try {
      final pref = await SharedPreferences.getInstance();
      String? token = pref.getString(GlobalVariables.tokenKey);
      if (token == null) {
        pref.setString(GlobalVariables.tokenKey, '');
      }
      var tokenRes = await http
          .post(Uri.parse('$uri/istokenValid'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        GlobalVariables.tokenKey: token!
      });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes =
            await http.get(Uri.parse('$uri/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          GlobalVariables.tokenKey: token
        });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
