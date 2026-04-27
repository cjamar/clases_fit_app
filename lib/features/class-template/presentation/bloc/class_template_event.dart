import 'package:clases_fit_app/features/class-template/domain/entities/class_template.dart';
import 'package:equatable/equatable.dart';

abstract class ClassTemplateEvent extends Equatable {
  const ClassTemplateEvent();

  @override
  List<Object?> get props => [];
}

class LoadTemplates extends ClassTemplateEvent {
  final String instructorId;
  const LoadTemplates(this.instructorId);

  @override
  List<Object?> get props => [instructorId];
}

class CreateTemplate extends ClassTemplateEvent {
  final ClassTemplate classTemplate;
  const CreateTemplate(this.classTemplate);

  @override
  List<Object?> get props => [classTemplate];
}

class UpdateTemplate extends ClassTemplateEvent {
  final ClassTemplate classTemplate;
  const UpdateTemplate(this.classTemplate);

  @override
  List<Object?> get props => [classTemplate];
}

class DeleteTemplate extends ClassTemplateEvent {
  final String classTemplateId;
  final String instructorId;
  const DeleteTemplate(this.classTemplateId, this.instructorId);

  @override
  List<Object?> get props => [classTemplateId, instructorId];
}
