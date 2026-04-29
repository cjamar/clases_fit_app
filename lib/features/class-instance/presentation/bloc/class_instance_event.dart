import 'package:equatable/equatable.dart';
import '../../domain/entities/class_instance.dart';

abstract class ClassInstanceEvent extends Equatable {
  const ClassInstanceEvent();

  @override
  List<Object?> get props => [];
}

class LoadClassInstancesEvent extends ClassInstanceEvent {
  final String scheduleId;
  final DateTime startTime;
  final DateTime endTime;

  const LoadClassInstancesEvent({
    required this.scheduleId,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object?> get props => [scheduleId, startTime, endTime];
}

class CreateClassInstanceEvent extends ClassInstanceEvent {
  final ClassInstance classInstance;
  const CreateClassInstanceEvent(this.classInstance);

  @override
  List<Object?> get props => [classInstance];
}

class UpdateClassInstanceEvent extends ClassInstanceEvent {
  final ClassInstance classInstance;
  const UpdateClassInstanceEvent(this.classInstance);

  @override
  List<Object?> get props => [classInstance];
}

class DeleteClassInstanceEvent extends ClassInstanceEvent {
  final String classInstanceId;
  const DeleteClassInstanceEvent(this.classInstanceId);

  @override
  List<Object?> get props => [classInstanceId];
}
