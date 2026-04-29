import '../../../weekly-slot/domain/repositories/weeky_slot_repository.dart';
import '../entities/class_instance.dart';
import '../repositories/class_instance_repository.dart';
import '../services/class_instance_generator_service.dart';

// class GenerateWeekClassInstances {
//   final ClassInstanceRepository repository;
//   GenerateWeekClassInstances(this.repository);

//   Future<List<ClassInstance>> call({
//     required String scheduleId,
//     required DateTime weekStart,
//     required DateTime weekEnd,
//   }) async => await repository.generateWeekClassInstances(
//     scheduleId,
//     weekStart,
//     weekEnd,
//   );
// }

class GenerateWeekClassInstances {
  final ClassInstanceRepository repository;
  final WeeklySlotRepository weeklySlotRepository;
  final ClassInstanceGeneratorService generator;

  GenerateWeekClassInstances(
    this.repository,
    this.weeklySlotRepository,
    this.generator,
  );

  Future<List<ClassInstance>> call({
    required String scheduleId,
    required DateTime weekStart,
    required DateTime weekEnd,
  }) async {
    // 1. Obtener slots (domain)
    final weeklySlots = await weeklySlotRepository.getWeeklySlotsBySchedule(
      scheduleId,
    );

    // 2. Generar instancias (domain pura)
    final instances = generator.generate(
      scheduleId: scheduleId,
      weeklySlots: weeklySlots,
      weekStart: weekStart,
      weekEnd: weekEnd,
    );

    // 3. Persistir (infra)
    await repository.insertClassInstances(instances);

    // 4. Obtener resultado final
    final result = await repository.getClassInstancesByWeek(
      scheduleId,
      weekStart,
      weekEnd,
    );

    return result;
  }
}
