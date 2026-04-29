import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/class_instance_model.dart';
import 'class_instance_datasource.dart';

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
  Future<List<ClassInstanceModel>> getClassInstancesByWeek(
    String scheduleId,
    DateTime weekStart,
    DateTime weekEnd,
  ) async {
    final result = await supabase
        .from('class_instances')
        .select()
        .eq('schedule_id', scheduleId)
        .gte('date', weekStart.toIso8601String())
        .lte('date', weekEnd.toIso8601String());

    return (result as List).map((e) => ClassInstanceModel.fromJson(e)).toList();
  }

  @override
  Future<void> insertClassInstances(List<Map<String, dynamic>> jsonList) async {
    await supabase.from('class_instances').insert(jsonList);
  }
}
