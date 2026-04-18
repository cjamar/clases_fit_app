import 'package:flutter/material.dart';

class AuthNameField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Size size;
  const AuthNameField({
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
          validator: (value) => _validateUserName(value),
          decoration: InputDecoration(
            hintText: 'Nombre de usuario',
            filled: true,
            fillColor: Colors.grey.shade200,
            border: _inputBorder(size, Colors.transparent),
            enabledBorder: _inputBorder(size, Colors.transparent),
            focusedErrorBorder: _inputBorder(size, Colors.transparent),
            focusedBorder: _inputBorder(size, Colors.blue),
            suffixIcon: value.text.isNotEmpty && focusNode.hasFocus
                ? _clearIconButton(size)
                : null,
          ),
        ),
      ),
    );
  }

  _validateUserName(String? value) {
    if (value == null || value.isEmpty) return 'Nombre de usuario requerido';

    return null;
  }

  _clearIconButton(Size size) => IconButton(
    onPressed: controller.clear,
    icon: Icon(Icons.close, color: Colors.black54, size: size.width * 0.05),
  );

  _inputBorder(Size size, Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(size.width * 0.02),
    borderSide: BorderSide(color: color, width: 1),
  );
}
