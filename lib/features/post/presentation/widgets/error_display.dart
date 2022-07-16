import 'package:flutter/material.dart';

class DisplayError extends StatelessWidget {
  final String msg;
  const DisplayError({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: Colors.red,
            size: 40.0,
          ),
          
          Text(
            msg,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
            ),
          )
        ],
      ),
    );
  }
}
