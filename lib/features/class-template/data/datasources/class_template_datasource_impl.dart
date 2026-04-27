import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/class_template_model.dart';
import 'class_template_datasource.dart';

class ClassTemplateDatasourceImpl extends ClassTemplateDatasource {
  final SupabaseClient supabase;
  ClassTemplateDatasourceImpl(this.supabase);

  @override
  Future<List<ClassTemplateModel>> getClassTemplatesByInstructor(
    String instructorId,
  ) async {
    final response = await supabase
        .from('class_templates')
        .select()
        .eq('instructor_id', instructorId);

    return (response as List)
        .map((e) => ClassTemplateModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> createClassTemplate(ClassTemplateModel classTemplate) async =>
      await supabase
          .from('class_templates')
          .insert({...classTemplate.toJson()}..remove('created_at'));

  @override
  Future<void> updateClassTemplate(ClassTemplateModel classTemplate) async =>
      await supabase
          .from('class_templates')
          .update(classTemplate.toJson())
          .eq('id', classTemplate.id);

  @override
  Future<void> deleteClassTemplate(String classTemplateId) async =>
      await supabase.from('class_templates').delete().eq('id', classTemplateId);
}
