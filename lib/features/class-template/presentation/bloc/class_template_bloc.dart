import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_class_template.dart';
import '../../domain/usecases/delete_class_template.dart';
import '../../domain/usecases/get_class_templates_by_instructor.dart';
import '../../domain/usecases/update_class_template.dart';
import 'class_template_event.dart';
import 'class_template_state.dart';

class ClassTemplateBloc extends Bloc<ClassTemplateEvent, ClassTemplateState> {
  final GetClassTemplatesByInstructor getClassTemplatesByInstructor;
  final CreateClassTemplate createClassTemplate;
  final UpdateClassTemplate updateClassTemplate;
  final DeleteClassTemplate deleteClassTemplate;

  ClassTemplateBloc({
    required this.getClassTemplatesByInstructor,
    required this.createClassTemplate,
    required this.updateClassTemplate,
    required this.deleteClassTemplate,
  }) : super(ClassTemplateInitial()) {
    on<LoadTemplates>((event, emit) async {
      emit(ClassTemplateLoading());
      try {
        await _reloadClassTemplates(emit, event.instructorId);
      } catch (e) {
        emit(ClassTemplateError(e.toString()));
      }
    });

    on<CreateTemplate>((event, emit) async {
      emit(ClassTemplateLoading());
      try {
        await createClassTemplate(event.classTemplate);
        await _reloadClassTemplates(emit, event.classTemplate.instructorId);
      } catch (e) {
        emit(ClassTemplateError(e.toString()));
      }
    });

    on<UpdateTemplate>((event, emit) async {
      emit(ClassTemplateLoading());
      try {
        await updateClassTemplate(event.classTemplate);
        await _reloadClassTemplates(emit, event.classTemplate.instructorId);
      } catch (e) {
        emit(ClassTemplateError(e.toString()));
      }
    });

    on<DeleteTemplate>((event, emit) async {
      emit(ClassTemplateLoading());
      try {
        await deleteClassTemplate(event.classTemplateId);
        await _reloadClassTemplates(emit, event.instructorId);
      } catch (e) {
        emit(ClassTemplateError(e.toString()));
      }
    });
  }

  Future<void> _reloadClassTemplates(
    Emitter<ClassTemplateState> emit,
    String instructorId,
  ) async {
    final templates = await getClassTemplatesByInstructor(instructorId);
    emit(ClassTemplateLoaded(templates, instructorId));
  }
}
