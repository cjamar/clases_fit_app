import '../entities/class_template.dart';
import '../repositories/class_template_repository.dart';

class GetClassTemplatesByInstructor {
  final ClassTemplateRepository repository;
  GetClassTemplatesByInstructor(this.repository);

  Future<List<ClassTemplate>> call(String instructorId) async =>
      await repository.getClassTemplatesByInstructor(instructorId);
}
