import 'package:clases_fit_app/features/class-instance/data/datasources/class_instance_datasource.dart';
import 'package:clases_fit_app/features/class-instance/data/models/class_instance_model.dart';
import 'package:clases_fit_app/features/weekly-slot/domain/entities/weekly_slot.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClassInstanceDatasourceImpl implements ClassInstanceDatasource {
  final SupabaseClient supabase;
  ClassInstanceDatasourceImpl(this.supabase);

  @override
  Future<List<ClassInstanceModel>> getClassInstance(
    String scheduleId,
    DateTime startTime,
    DateTime endTime,
  ) async {
    final data = await supabase
        .from('class_instances')
        .select()
        .eq('schedule_id', scheduleId)
        .gte('date', startTime.toIso8601String())
        .lte('date', endTime.toIso8601String())
        .order('data', ascending: true);
    return (data as List).map((e) => ClassInstanceModel.fromJson(e)).toList();
  }

  @override
  Future<void> createClassInstance(
    ClassInstanceModel classInstanceModel,
  ) async => await supabase
      .from('class_instances')
      .insert(classInstanceModel.toJson());

  @override
  Future<void> updateClassInstance(
    ClassInstanceModel classInstanceModel,
  ) async => await supabase
      .from('class_instances')
      .update(classInstanceModel.toJson())
      .eq('id', classInstanceModel.id);

  @override
  Future<void> deleteClassInstance(String classInstanceId) async =>
      await supabase.from('class_instances').delete().eq('id', classInstanceId);

  @override
  Future<List<ClassInstanceModel>> generateWeekClassInstances(
    String scheduleId,
    DateTime weekStart,
    DateTime weekEnd,
  ) async {
    // 1. Traer todos los WeeklySlots activos del horario
    final weeklySlots = await supabase
        .from('weekly_slots')
        .select()
        .eq('schedule_id', scheduleId)
        .eq('is_active', true);

    // 2. Traer las ClassInstances ya existentes en esa semana
    final existingClasses = await supabase
        .from('class_instances')
        .select()
        .eq('schedule_id', scheduleId)
        .gte('date', weekStart.toIso8601String())
        .lte('date', weekEnd.toIso8601String());

    // 3. Lista donde guardaremos nuevas clases a crear
    final List<Map<String, dynamic>> toInsert = [];

    // 4. Recorrer cada WeeklySlot (regla semanal)
    for (final ws in weeklySlots) {
      final int dayOfWeek = ws['day_of_week'];
      DateTime current = weekStart;

      // 5. Recorrer todos los días de la semana
      while (current.isBefore(weekEnd) || current.isAtSameMomentAs(weekEnd)) {
        // 6. Solo si el día coincide con el slot
        if (current.weekday == dayOfWeek) {
          // 7. Evitar duplicados
          final exists = existingClasses.any(
            (e) =>
                e['date'] == current.toIso8601String() &&
                e['class_template_id'] == ws['class_template_id'],
          );
          // 8. Si no existe → lo generamos
          if (!exists) {
            toInsert.add({
              'schedule_id': scheduleId,
              'class_template_id': ws['class_template_id'],
              'weekly_slot_id': ws['id'],
              'date': current.toIso8601String(),
              'start_time': ws['start_time'],
              'end_time': ws['end_time'],
              'status': 'available',
              'min_capacity': ws['min_capacity'],
              'max_capacity': ws['max_capacity'],
              'current_bookings': 0,
            });
          }
        }
        // 9. Avanzar al siguiente día
        current = current.add(const Duration(days: 1));
      }
    }
    // 10. Insertar nuevas clases en Supabase
    if (toInsert.isNotEmpty) {
      await supabase.from('class_instances').insert(toInsert);
    }

    // 11. Devolver semana completa (ya existente + nuevas)
    final result = await supabase
        .from('class_instances')
        .select()
        .eq('schedule_id', scheduleId)
        .gte('date', weekStart.toIso8601String())
        .lte('date', weekEnd.toIso8601String());

    return (result as List).map((e) => ClassInstanceModel.fromJson(e)).toList();
  }
}
