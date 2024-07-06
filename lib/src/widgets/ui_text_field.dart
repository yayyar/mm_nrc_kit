import 'package:flutter/material.dart';

class UITextField extends StatelessWidget {
  UITextField(
      {super.key,
      this.controller,
      this.onChanged,
      this.valueColor,
      this.focusColor});

  void Function(String)? onChanged;
  final TextEditingController? controller;
  final Color? valueColor;
  final Color? focusColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      enabled: false,
      onChanged: onChanged,
      controller: controller,
      textDirection: TextDirection.rtl,
      maxLength: 1,
      keyboardType: TextInputType.number,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(color: valueColor ?? Colors.black, fontSize: 20),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        counterText: "",
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: focusColor ?? Colors.grey)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: Colors.red)),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: Colors.red)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 1, color: Colors.deepPurple)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(width: 0.5, color: Colors.grey)),
      ),
    );
  }
}
