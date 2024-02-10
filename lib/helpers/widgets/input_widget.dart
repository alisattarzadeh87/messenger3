import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputWidget extends StatefulWidget {
  const InputWidget(
      {super.key,
      required this.hint,
      this.icon,
      this.type,
      this.disabled = false,
      this.controller,
      this.validator,
      this.onChanged,
      this.onTap
      });

  final String hint;
  final IconData? icon;
  final TextInputType? type;
  final bool disabled;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {

  bool obscure = true;
  bool get isPassword => widget.type == TextInputType.visiblePassword;
  IconData get passwordIcon => obscure ? FeatherIcons.eyeOff : FeatherIcons.eye;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.type ?? TextInputType.text,
      obscureText: isPassword ? obscure : false,
      readOnly: widget.disabled,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      decoration: InputDecoration(
        filled: true,
        hintText: widget.hint,
        fillColor: context.theme.colorScheme.tertiary,
        contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        suffixIcon: widget.icon != null || isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                child: Icon(isPassword ? passwordIcon : widget.icon))
            : null,
      ),
    );
  }
}
