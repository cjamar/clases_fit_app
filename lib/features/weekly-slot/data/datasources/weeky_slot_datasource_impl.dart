import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/weekly_slot_model.dart';
import 'weekly_slot_datasource.dart';

class WeekySlotDatasourceImpl implements WeeklySlotDatasource {
  final SupabaseClient supabase;
  WeekySlotDatasourceImpl(this.supabase);

  @override
  Future<List<WeeklySlotModel>> getWeeklySlotsBySchedule(
    String scheduleId,
  ) async {
    final data = await supabase
        .from('weekly_slots')
        .select()
        .eq('schedule_id', scheduleId);
    return (data as List).map((e) => WeeklySlotModel.fromJson(e)).toList();
  }

  @override
  Future<void> createWeeklySlot(WeeklySlotModel weeklySlot) async =>
      await supabase.from('weekly_slots').insert(weeklySlot.toJson());

  @override
  Future<void> updateWeeklySlot(WeeklySlotModel weeklySlot) async =>
      await supabase
          .from('weekly_slots')
          .update(weeklySlot.toJson())
          .eq('id', weeklySlot.id);

  @override
  Future<void> deleteWeeklySlot(String weeklySlotId) async =>
      await supabase.from('weekly_slots').delete().eq('id', weeklySlotId);
}
