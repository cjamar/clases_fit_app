import 'package:clases_fit_app/core/theme/styles_app.dart';
import 'package:flutter/material.dart';

class AuthEmailField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Size size;
  const AuthEmailField({
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
          keyboardType: TextInputType.emailAddress,
          validator: (value) => _validateEmail(value),
          decoration: InputDecoration(
            hintText: 'Email',
            filled: true,
            fillColor: StylesApp.greyColor100,
            border: _inputBorder(size, Colors.transparent),
            enabledBorder: _inputBorder(size, Colors.transparent),
            focusedErrorBorder: _inputBorder(size, Colors.transparent),
            focusedBorder: _inputBorder(size, StylesApp.primaryColor),
            suffixIcon: value.text.isNotEmpty && focusNode.hasFocus
                ? _clearIconButton(size)
                : null,
          ),
        ),
      ),
    );
  }

  _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email requerido';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Email inválido';
    }
    return null;
  }

  _clearIconButton(Size size) => IconButton(
    onPressed: controller.clear,
    icon: Icon(
      Icons.close,
      color: StylesApp.greyColor600,
      size: size.width * 0.05,
    ),
  );

  _inputBorder(Size size, Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(size.width * 0.02),
    borderSide: BorderSide(color: color, width: 1),
  );
}
