import 'package:clases_fit_app/core/theme/styles_app.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:clases_fit_app/features/auth/presentation/widgets/auth_name_field.dart';
import 'package:clases_fit_app/features/schedule/domain/entities/schedule.dart';
import 'package:clases_fit_app/features/schedule/presentation/bloc/schedule_bloc.dart';
import 'package:clases_fit_app/features/schedule/presentation/bloc/schedule_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/presentation/widgets/auth_submit_button.dart';

class CreateSchedulePage extends StatefulWidget {
  const CreateSchedulePage({super.key});

  @override
  State<CreateSchedulePage> createState() => _CreateSchedulePageState();
}

class _CreateSchedulePageState extends State<CreateSchedulePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nameFocus = FocusNode();
  final ValueNotifier<bool> _isValid = ValueNotifier(false);
  final _userId = Supabase.instance.client.auth.currentUser!.id;

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
    final scheduleName = _nameController.text.trim();
    final scheduleNameValid =
        scheduleName.isNotEmpty && scheduleName.length >= 3;
    _isValid.value = scheduleNameValid;
  }

  _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final Schedule schedule = Schedule(
      id: '',
      instructorId: _userId,
      name: _nameController.text.trim(),
      createdAt: DateTime.now(),
    );

    context.read<ScheduleBloc>().add(CreateScheduleEvent(schedule));
    _nameController.clear();

    _backToHome();
  }

  _backToHome() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text('Crea un horario'),
        ),
        body: _createScheduleBody(size),
      ),
    );
  }

  _createScheduleBody(Size size) => SizedBox(
    width: size.width,
    height: size.height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //  _headerArea(size),
        _formArea(size),
      ],
    ),
  );

  // _headerArea(Size size) => Container(
  //   height: size.height * 0.2,
  //   color: Colors.greenAccent,
  //   child: Center(
  //     child: Text('Crea un horario', style: StylesApp.titleTextStyle),
  //   ),
  // );

  _formArea(Size size) => Container(
    height: size.height * 0.7,
    color: Colors.lightBlueAccent,
    child: Form(
      key: _formKey,
      child: AuthForm(
        fields: [
          AuthNameField(
            controller: _nameController,
            focusNode: _nameFocus,
            size: size,
          ),
          SizedBox(height: size.height * 0.1),
        ],
        submitButton: ValueListenableBuilder<bool>(
          valueListenable: _isValid,
          builder: (context, isValid, child) => AuthSubmitButton(
            text: 'Registrarme',
            onPressed: isValid ? _onSubmit : null,
            size: size,
          ),
        ),
      ),
    ),
  );
}
