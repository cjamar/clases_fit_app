import 'package:equatable/equatable.dart';

import '../../domain/entities/class_instance.dart';

abstract class ClassInstanceState extends Equatable {
  const ClassInstanceState();

  @override
  List<Object?> get props => [];
}

class ClassInstanceInitial extends ClassInstanceState {}

class ClassInstanceLoading extends ClassInstanceState {}

class ClassInstanceLoaded extends ClassInstanceState {
  final List<ClassInstance> classInstanceList;
  final String scheduleId;
  final DateTime startTime;
  final DateTime endTime;

  const ClassInstanceLoaded({
    required this.classInstanceList,
    required this.scheduleId,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object?> get props => [
    classInstanceList,
    scheduleId,
    startTime,
    endTime,
  ];
}

class ClassInstanceError extends ClassInstanceState {
  final String message;
  const ClassInstanceError(this.message);

  @override
  List<Object?> get props => [message];
}
