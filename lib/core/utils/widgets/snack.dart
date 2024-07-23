import 'package:flutter/material.dart';

class ErrorSnackBar extends StatelessWidget {
  final String errorMessage;

  const ErrorSnackBar({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
      ),
    );
    return Container();
  }
}