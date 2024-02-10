import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.text,
      this.isSecondary = false,
      required this.onPressed,
      this.loading = false});

  final String text;
  final bool isSecondary;
  final VoidCallback onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: loading ? null : onPressed,
      disabledColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      minWidth: double.infinity,
      elevation: 0,
      height: 47,
      color: isSecondary
          ? context.theme.colorScheme.secondary
          : context.theme.colorScheme.primary,
      child:
      loading ? SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(color: Colors.white,)) : Text(text,
        style: context.textTheme.titleMedium?.apply(color: Colors.white),
      ),
    );
  }
}
