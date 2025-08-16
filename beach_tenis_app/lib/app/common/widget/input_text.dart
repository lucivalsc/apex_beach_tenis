import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String? labeltext;
  final TextEditingController? controller;
  final TextInputType? typeKeyboard;
  final Function(String)? onchanged;
  final bool password;
  final Function()? funcIcon;
  final IconData? icon;

  const InputText({
    Key? key,
    this.labeltext,
    this.controller,
    this.typeKeyboard,
    this.onchanged,
    this.password = false,
    this.funcIcon,
    this.icon,
  }) : super(key: key);

  const InputText.password({
    Key? key,
    this.labeltext,
    this.controller,
    this.typeKeyboard,
    this.onchanged,
    this.password = true,
    this.funcIcon,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0, top: 10, right: 0),
      child: TextField(
        obscureText: password,
        onChanged: onchanged,
        keyboardType: typeKeyboard,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          labelText: labeltext,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.black38,
            ),
          ),
          suffixIcon: funcIcon != null
              ? IconButton(
                  onPressed: funcIcon,
                  icon: Icon(
                    icon,
                    color: Colors.black38,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
