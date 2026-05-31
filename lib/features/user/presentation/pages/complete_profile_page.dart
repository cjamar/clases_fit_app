import 'package:clases_fit_app/core/theme/styles_app.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_name_field.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_phone_field.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:clases_fit_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:clases_fit_app/features/user/presentation/bloc/user_event.dart';
import 'package:clases_fit_app/features/user/presentation/bloc/user_state.dart';
import 'package:clases_fit_app/features/user/presentation/widgets/image_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import '../../domain/entities/user.dart';
import '../../domain/entities/user_role.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final ValueNotifier<bool> _isValid = ValueNotifier(false);
  String? _avatarUrl;
  bool _isUploadingImage = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validate);
    _phoneController.addListener(_validate);
    _nameFocus.addListener(() => setState(() {}));
    _phoneFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  _validate() {
    final userName = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final userNameValid = userName.isNotEmpty && userName.length >= 3;
    final phoneValid = phone.isNotEmpty && phone.length >= 9;
    _isValid.value = userNameValid && phoneValid && !_isUploadingImage;
  }

  _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    print('ON SUBMIT completeprofilepage');

    final authUser = Supabase.instance.client.auth.currentUser;

    if (authUser == null) {
      _snackbar('Usuario no autenticado', StylesApp.alertColor);
      return;
    }

    final user = User(
      id: authUser.id,
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      avatarUrl: _avatarUrl,
      role: UserRole.owner,
    );

    context.read<UserBloc>().add(CreateUserEvent(user));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: StylesApp.whiteColor,
        resizeToAvoidBottomInset: false,
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserAvatarUploadingState) {
              setState(() {
                _isUploadingImage = true;
              });
            }
            if (state is UserAvatarUploadedState) {
              setState(() {
                _avatarUrl = state.avatarUrl;
                _isUploadingImage = false;
              });
              _validate();
            }
            if (state is UserExistState) {
              _snackbar(
                'Perfil completado correctamente',
                StylesApp.primaryColor,
              );
            }
            if (state is UserErrorState) {
              setState(() {
                _isUploadingImage = false;
              });
              _snackbar(state.message, StylesApp.alertColor);
            }
          },
          child: _completeProfileBody(size),
        ),
      ),
    );
  }

  _completeProfileBody(Size size) => SizedBox(
    width: size.width,
    height: size.height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_formArea(size)],
    ),
  );

  _formArea(Size size) => Form(
    key: _formKey,
    child: AuthForm(
      fields: [
        AuthNameField(
          controller: _nameController,
          focusNode: _nameFocus,
          size: size,
        ),
        SizedBox(height: size.height * 0.05),
        AuthPhoneField(
          controller: _phoneController,
          focusNode: _phoneFocus,
          size: size,
        ),
        SizedBox(height: size.height * 0.05),
        _imageUserArea(size),
        SizedBox(height: size.height * 0.15),
      ],
      submitButton: ValueListenableBuilder<bool>(
        valueListenable: _isValid,
        builder: (_, isValid, _) => AuthSubmitButton(
          text: 'Completar Perfil',
          onPressed: isValid ? _onSubmit : null,
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
    ],
  );

  _circleAvatarImage(Size size) => CircleAvatar(
    backgroundColor: StylesApp.greyColor100,
    radius: size.width * 0.3,
    backgroundImage: _avatarUrl != null ? NetworkImage(_avatarUrl!) : null,
    child: _avatarUrl == null
        ? Icon(
            Icons.person,
            size: size.width * 0.15,
            color: StylesApp.greyColor500,
          )
        : _isUploadingImage
        ? CircularProgressIndicator(color: StylesApp.whiteColor)
        : null,
  );

  _iconAddPicture(Size size) => Positioned(
    top: size.width * 0.1,
    right: size.width * 0.1,
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withAlpha(50),
      ),
      child: IconButton(
        onPressed: () => _imagePickerButton(size),
        icon: Icon(
          Icons.add_a_photo,
          size: size.width * 0.1,
          color: StylesApp.whiteColor,
        ),
      ),
    ),
  );

  _imagePickerButton(Size size) => ImageSelector.show(
    context: context,
    size: size,
    onImageSelected: (source) => _pickImage(source),
  );

  _pickImage(ImageSource source) =>
      context.read<UserBloc>().add(UploadAvatarEvent(source));

  _snackbar(String text, Color color) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error, $text'), backgroundColor: color),
      );
}
