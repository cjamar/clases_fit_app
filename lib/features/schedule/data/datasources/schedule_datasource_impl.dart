import 'package:clases_fit_app/features/schedule/data/datasources/schedule_datasource.dart';
import 'package:clases_fit_app/features/schedule/data/models/schedule_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScheduleDatasourceImpl implements ScheduleDatasource {
  final SupabaseClient supabase;
  ScheduleDatasourceImpl(this.supabase);

  @override
  Future<List<ScheduleModel>> getClassTemplatesByInstructor(
    String instructorId,
  ) async {
    final data = await supabase
        .from('schedules')
        .select()
        .eq('instructor_id', instructorId);
    return (data as List).map((e) => ScheduleModel.fromJson(e)).toList();
  }

  @override
  Future<void> createSchedule(ScheduleModel schedule) async =>
      await supabase.from('schedules').insert(schedule.toJson());

  @override
  Future<void> updateSchedule(ScheduleModel schedule) async => await supabase
      .from('schedules')
      .update(schedule.toJson())
      .eq('id', schedule.id);

  @override
  Future<void> deleteSchedule(String scheduleId) async =>
      await supabase.from('schedules').delete().eq('id', scheduleId);
}
