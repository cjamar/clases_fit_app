import 'package:clases_fit_app/core/theme/styles_app.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_name_field.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:clases_fit_app/features/user/presentation/widgets/image_selector.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  String? _avatarUrl;
  bool _isUploadingImage = false;

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
    _isValid.value = userNameValid && !_isUploadingImage;
  }

  _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    print('ON SUBMIT completeprofilepage');
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _completeProfileBody(size),
      ),
    );
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
    // height: size.height * 0.7,
    color: Colors.greenAccent,
    child: Form(
      key: _formKey,
      child: AuthForm(
        fields: [
          AuthNameField(
            controller: _nameController,
            focusNode: _nameFocus,
            size: size,
          ),
          SizedBox(height: size.height * 0.05),
          _imageUserArea(size),
          SizedBox(height: size.height * 0.2),
        ],
        submitButton: AuthSubmitButton(
          text: 'Completar Perfil',
          onPressed: _onSubmit,
          size: size,
        ),
      ),
    ),
  );

  _imageUserArea(Size size) => Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [_circleAvatarImage(size), _iconAddPicture(size)],
      ),
      if (_isUploadingImage) ...[
        SizedBox(height: size.height * 0.05),
        CircularProgressIndicator(),
      ],
    ],
  );

  _circleAvatarImage(Size size) => CircleAvatar(
    backgroundColor: StylesApp.whiteColor,
    radius: size.width * 0.3,
    backgroundImage: _avatarUrl != null ? NetworkImage(_avatarUrl!) : null,
    child: _avatarUrl == null
        ? Icon(
            Icons.person,
            size: size.width * 0.15,
            color: StylesApp.greyColor500,
          )
        : null,
  );

  _iconAddPicture(Size size) => Positioned(
    top: size.width * 0.1,
    right: size.width * 0.1,
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withAlpha(30),
      ),
      child: IconButton(
        onPressed: () => _imagePickerButton(size),
        icon: Icon(
          Icons.add_a_photo,
          size: size.width * 0.1,
          color: StylesApp.primaryColor,
        ),
      ),
    ),
  );

  _imagePickerButton(Size size) => ImageSelector.show(
    context: context,
    size: size,
    onImageSelected: (source) => _pickImage(source),
  );

  _pickImage(ImageSource source) {
    print('PRINT image picker --> $source');
  }
}
