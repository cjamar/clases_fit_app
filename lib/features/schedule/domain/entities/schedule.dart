import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final String id;
  final String instructorId;
  final String name;
  final DateTime createdAt;
  // TODO: PODRIAMOS AÑADIR START DAYTIME Y END DAYTIME (para que el horario diario visual no tenga 24h sino de 8:00 a 21:00, definible al instructor)
  const Schedule({
    required this.id,
    required this.instructorId,
    required this.name,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, instructorId, name, createdAt];
}
