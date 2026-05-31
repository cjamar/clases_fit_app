import 'package:flutter/material.dart';
import '../../../../core/theme/styles_app.dart';

class AuthPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Size size;

  const AuthPhoneField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.8,
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, child) => TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.phone,
          validator: _validatePhone,
          decoration: InputDecoration(
            hintText: 'Teléfono',
            filled: true,
            fillColor: StylesApp.greyColor100,
            border: _inputBorder(size, Colors.transparent),
            enabledBorder: _inputBorder(size, Colors.transparent),
            focusedBorder: _inputBorder(size, StylesApp.primaryColor),
            suffixIcon: value.text.isNotEmpty && focusNode.hasFocus
                ? IconButton(
                    onPressed: controller.clear,
                    icon: Icon(Icons.close),
                  )
                : null,
          ),
        ),
      ),
    );
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return null; // opcional
    if (!RegExp(r'^\+?[0-9]{9,15}$').hasMatch(value)) {
      return 'Teléfono inválido';
    }
    return null;
  }

  OutlineInputBorder _inputBorder(Size size, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(size.width * 0.02),
      borderSide: BorderSide(color: color),
    );
  }
}
