import 'package:clases_fit_app/core/theme/styles_app.dart';
import 'package:clases_fit_app/features/schedule/domain/entities/schedule.dart';
import 'package:clases_fit_app/features/schedule/presentation/bloc/schedule_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../schedule/presentation/bloc/schedule_bloc.dart';
import '../../../schedule/presentation/bloc/schedule_state.dart';
import '../../../schedule/presentation/pages/create_schedule_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final userId = Supabase.instance.client.auth.currentUser!.id;
    context.read<ScheduleBloc>().add(LoadSchedulesEvent(userId));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: StylesApp.secondaryColor,
        title: Text('HomePage'),
      ),
      backgroundColor: StylesApp.whiteColor,
      body: _homeBody(size),
    );
  }

  Widget? _homeBody(Size size) => SizedBox(
    width: size.width,
    height: size.height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_calendarBody(size)],
    ),
  );

  _calendarBody(Size size) => SizedBox(
    width: size.width,
    height: size.height * 0.7,
    child: BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        if (state is ScheduleLoading) {
          return _loader();
        }
        if (state is ScheduleLoaded) {
          if (state.scheduleList.isEmpty) {
            _emptySchedulesContainer(size);
          }
          return _calendarView(size, state.scheduleList.first);
        }
        if (state is ScheduleError) {
          _errorContainer(size, state.message);
        }
        return _loader();
      },
    ),
    // child: Center(child: _returnDataCalendarButton(size)),
  );

  _calendarView(Size size, Schedule schedule) => Container(
    color: StylesApp.secondaryColor,
    child: Center(child: Text('Schedule --> ${schedule.name}')),
  );

  _emptySchedulesContainer(Size size) => Container(
    height: size.height * 0.3,
    color: StylesApp.tertiaryColor,
    child: Column(
      children: [
        Text('Vaya, parece que aún no tienes ningún calendario. !Crea uno!'),
        _createScheduleButton(size),
      ],
    ),
  );

  _createScheduleButton(Size size) => SizedBox(
    width: size.width * 0.8,
    height: size.height * 0.05,
    child: ElevatedButton(
      onPressed: () => goToCreateSchedulePage(),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.grey.shade300,
        disabledForegroundColor: Colors.white,
        backgroundColor: StylesApp.primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Crear un horario'),
          SizedBox(width: size.width * 0.03),
          Icon(Icons.apps_rounded, size: size.width * 0.07),
        ],
      ),
    ),
  );

  goToCreateSchedulePage() => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CreateSchedulePage()),
  );

  _loader() => CircularProgressIndicator();

  _errorContainer(Size size, String message) => Container(
    height: size.height * 0.3,
    child: Column(
      children: [
        Icon(Icons.error),
        SizedBox(height: size.height * 0.2),
        Text('Ha ocurrido un error, $message'),
      ],
    ),
  );
}
