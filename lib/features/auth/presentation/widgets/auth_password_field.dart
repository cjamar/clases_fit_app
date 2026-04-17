import 'package:flutter/material.dart';

class AuthPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final Size size;
  const AuthPasswordField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.label = 'Contraseña',
    required this.size,
  });

  @override
  State<AuthPasswordField> createState() => _AuthPasswordFieldState();
}

class _AuthPasswordFieldState extends State<AuthPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width * 0.8,
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: widget.controller,
        builder: (context, value, child) => TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: _obscureText,
          validator: (value) => _validatePassword(value),
          decoration: InputDecoration(
            hintText: widget.label,
            filled: true,
            fillColor: Colors.grey.shade200,
            border: _inputBorder(widget.size, Colors.transparent),
            enabledBorder: _inputBorder(widget.size, Colors.transparent),
            focusedErrorBorder: _inputBorder(widget.size, Colors.transparent),
            focusedBorder: _inputBorder(widget.size, Colors.blue),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (value.text.isNotEmpty && widget.focusNode.hasFocus)
                  _clearIconButton(),
                _obscureIconButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _obscureIconButton() => IconButton(
    onPressed: () => setState(() {
      _obscureText = !_obscureText;
    }),
    icon: Icon(
      _obscureText ? Icons.visibility : Icons.visibility_off,
      color: Colors.grey.shade500,
    ),
  );

  _clearIconButton() => IconButton(
    onPressed: widget.controller.clear,
    icon: Icon(
      Icons.close,
      color: Colors.black54,
      size: widget.size.width * 0.05,
    ),
  );

  _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Contraseña requerida';
    if (value.length < 6) return 'Minimo 6 caracteres';
    return null;
  }

  _inputBorder(Size size, Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(size.width * 0.02),
    borderSide: BorderSide(color: color, width: 1),
  );
}
