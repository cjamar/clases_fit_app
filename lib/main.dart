import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/app/auth_gate.dart';
import 'features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/get_current_session.dart';
import 'features/auth/domain/usecases/google_sign_in.dart';
import 'features/auth/domain/usecases/reset_password.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/domain/usecases/sign_out.dart';
import 'features/auth/domain/usecases/sign_up.dart';
import 'features/auth/domain/usecases/update_password.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/class-instance/data/datasources/class_instance_datasource_impl.dart';
import 'features/class-instance/data/repositories/class_instance_repository_impl.dart';
import 'features/class-instance/domain/services/class_instance_generator_service.dart';
import 'features/class-instance/domain/usecases/create_class_instance.dart';
import 'features/class-instance/domain/usecases/delete_class_instance.dart';
import 'features/class-instance/domain/usecases/generate_week_class_instances.dart';
import 'features/class-instance/domain/usecases/update_class_instance.dart';
import 'features/class-instance/presentation/bloc/class_instance_bloc.dart';
import 'features/class-template/data/datasources/class_template_datasource_impl.dart';
import 'features/class-template/data/repositories/class_template_repository_impl.dart';
import 'features/class-template/domain/usecases/create_class_template.dart';
import 'features/class-template/domain/usecases/delete_class_template.dart';
import 'features/class-template/domain/usecases/get_class_templates_by_instructor.dart';
import 'features/class-template/domain/usecases/update_class_template.dart';
import 'features/class-template/presentation/bloc/class_template_bloc.dart';
import 'features/schedule/data/datasources/schedule_datasource_impl.dart';
import 'features/schedule/data/repositories/schedule_repository_impl.dart';
import 'features/schedule/domain/usecases/create_schedule.dart';
import 'features/schedule/domain/usecases/delete_schedule.dart';
import 'features/schedule/domain/usecases/get_schedules_by_instructor.dart';
import 'features/schedule/domain/usecases/update_schedule.dart';
import 'features/schedule/presentation/bloc/schedule_bloc.dart';
import 'features/weekly-slot/data/datasources/weeky_slot_datasource_impl.dart';
import 'features/weekly-slot/data/repositories/weekly_slot_repository_impl.dart';
import 'features/weekly-slot/domain/usecases/create_weekly_slot.dart';
import 'features/weekly-slot/domain/usecases/delete_weekly_slot.dart';
import 'features/weekly-slot/domain/usecases/get_weekly_slots_by_schedule.dart';
import 'features/weekly-slot/domain/usecases/update_weekly_slot.dart';
import 'features/weekly-slot/presentation/bloc/weekly_slot_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://nnkzposckczjchppcbrm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5ua3pwb3Nja2N6amNocHBjYnJtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY0NDIzMDksImV4cCI6MjA5MjAxODMwOX0.2znOWktXwRw3r4M7bWQcUl62jK9vX7L0nWHwzqBl4co',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late final supabase = Supabase.instance.client;

  // AUTH
  late final authRemoteDatasource = AuthRemoteDatasourceImpl(supabase);
  late final authRepository = AuthRepositoryImpl(authRemoteDatasource);

  late final signIn = SignIn(authRepository);
  late final signUp = SignUp(authRepository);
  late final googleSignIn = GoogleSignIn(authRepository);
  late final signOut = SignOut(authRepository);
  late final getCurrentSession = GetCurrentSession(authRepository);
  late final resetPassword = ResetPassword(authRepository);
  late final updatePassword = UpdatePassword(authRepository);

  // SCHEDULE
  late final scheduleDatasource = ScheduleDatasourceImpl(supabase);
  late final scheduleRepository = ScheduleRepositoryImpl(scheduleDatasource);

  late final getSchedulesByInstructor = GetSchedulesByInstructor(
    scheduleRepository,
  );
  late final createSchedule = CreateSchedule(scheduleRepository);
  late final updateSchedule = UpdateSchedule(scheduleRepository);
  late final deleteSchedule = DeleteSchedule(scheduleRepository);

  // WEEKLY SLOT
  late final weeklySlotDatasource = WeekySlotDatasourceImpl(supabase);
  late final weeklySlotRepository = WeeklySlotRepositoryImpl(
    weeklySlotDatasource,
  );

  late final getWeeklySlotsBySchedule = GetWeeklySlotsBySchedule(
    weeklySlotRepository,
  );
  late final createWeeklySlot = CreateWeeklySlot(weeklySlotRepository);
  late final updateWeeklySlot = UpdateWeeklySlot(weeklySlotRepository);
  late final deleteWeeklySlot = DeleteWeeklySlot(weeklySlotRepository);

  // CLASS TEMPLATE
  late final classTemplateDatasource = ClassTemplateDatasourceImpl(supabase);
  late final classTemplateRepository = ClassTemplateRepositoryImpl(
    classTemplateDatasource,
  );

  late final getClassTemplatesByInstructor = GetClassTemplatesByInstructor(
    classTemplateRepository,
  );
  late final createClassTemplate = CreateClassTemplate(classTemplateRepository);
  late final updateClassTemplate = UpdateClassTemplate(classTemplateRepository);
  late final deleteClassTemplate = DeleteClassTemplate(classTemplateRepository);

  // CLASS INSTANCE
  late final classInstanceDatasource = ClassInstanceDatasourceImpl(supabase);
  late final classInstanceRepository = ClassInstanceRepositoryImpl(
    classInstanceDatasource,
  );

  late final classInstanceGenerator = ClassInstanceGeneratorService();
  late final generateWeekClassInstances = GenerateWeekClassInstances(
    classInstanceRepository,
    weeklySlotRepository,
    classInstanceGenerator,
  );
  late final createClassInstance = CreateClassInstance(classInstanceRepository);
  late final updateClassInstance = UpdateClassInstance(classInstanceRepository);
  late final deleteClassInstance = DeleteClassInstance(classInstanceRepository);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            signIn: signIn,
            signUp: signUp,
            googleSignIn: googleSignIn,
            signOut: signOut,
            getCurrentSession: getCurrentSession,
            resetPassword: resetPassword,
            updatePassword: updatePassword,
          )..add(AppStarted()),
        ),
        BlocProvider<ScheduleBloc>(
          create: (_) => ScheduleBloc(
            getSchedulesByInstructor: getSchedulesByInstructor,
            createSchedule: createSchedule,
            updateSchedule: updateSchedule,
            deleteSchedule: deleteSchedule,
          ),
        ),
        BlocProvider<WeeklySlotBloc>(
          create: (_) => WeeklySlotBloc(
            getWeeklySlotsBySchedule: getWeeklySlotsBySchedule,
            createWeeklySlot: createWeeklySlot,
            updateWeeklySlot: updateWeeklySlot,
            deleteWeeklySlot: deleteWeeklySlot,
          ),
        ),
        BlocProvider<ClassTemplateBloc>(
          create: (_) => ClassTemplateBloc(
            getClassTemplatesByInstructor: getClassTemplatesByInstructor,
            createClassTemplate: createClassTemplate,
            updateClassTemplate: updateClassTemplate,
            deleteClassTemplate: deleteClassTemplate,
          ),
        ),
        BlocProvider<ClassInstanceBloc>(
          create: (_) => ClassInstanceBloc(
            generateWeekClassInstances: generateWeekClassInstances,
            createClassInstance: createClassInstance,
            updateClassInstance: updateClassInstance,
            deleteClassInstance: deleteClassInstance,
          ),
        ),
      ],
      child: MaterialApp(
        // theme: PENDIENTE DE DEFINIR Y COLOCAR EL THEME,
        debugShowCheckedModeBanner: false,
        home: const AuthGate(),
      ),
    );
  }
}
