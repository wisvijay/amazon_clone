import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import '/constants/global_variables.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case GlobalVariables.authRouteName:
      return MaterialPageRoute(
        builder: (context) => const AuthScreen(),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      );
  }
}
