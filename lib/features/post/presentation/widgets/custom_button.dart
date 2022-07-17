import 'package:flutter/material.dart';

class CusomButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget icon;
  final Widget label;
  const CusomButton(
      {Key? key, this.onPressed, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: label,
    );
  }
}
