import 'package:flutter/material.dart';

class SnakBarMessages {
  void showSnackBar(BuildContext context, String message, Color bgcolor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: bgcolor,
    ));
  }
}
