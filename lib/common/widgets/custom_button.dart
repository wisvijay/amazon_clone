import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? action;
  const CustomButton({super.key, required this.text, this.action});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 50),
        ),
        child: Text(text));
  }
}
