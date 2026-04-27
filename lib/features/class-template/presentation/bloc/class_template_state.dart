import 'package:equatable/equatable.dart';
import '../../domain/entities/class_template.dart';

abstract class ClassTemplateState extends Equatable {
  const ClassTemplateState();

  @override
  List<Object?> get props => [];
}

class ClassTemplateInitial extends ClassTemplateState {}

class ClassTemplateLoading extends ClassTemplateState {}

class ClassTemplateLoaded extends ClassTemplateState {
  final List<ClassTemplate> classTemplates;
  final String instructorId;
  const ClassTemplateLoaded(this.classTemplates, this.instructorId);

  @override
  List<Object?> get props => [classTemplates, instructorId];
}

class ClassTemplateError extends ClassTemplateState {
  final String message;
  const ClassTemplateError(this.message);

  @override
  List<Object?> get props => [message];
}
