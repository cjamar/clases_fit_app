import 'package:flutter/material.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nameFocus = FocusNode();
  final ValueNotifier<bool> _isValid = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validate);
    _nameFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  _validate() {
    final userName = _nameController.text.trim();
    final userNameValid = userName.isNotEmpty && userName.length >= 3;
    _isValid.value = userNameValid;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(body: _completeProfileBody(size));
  }

  _completeProfileBody(Size size) => Container(
    color: Colors.yellow,
    width: size.width,
    height: size.height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_formArea(size)],
    ),
  );

  _formArea(Size size) => Container(
    height: size.height * 0.7,
    child: Center(child: Text('complete profile page')),
  );
}
