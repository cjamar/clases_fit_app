import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_class_instance.dart';
import '../../domain/usecases/delete_class_instance.dart';
import '../../domain/usecases/generate_week_class_instances.dart';
import '../../domain/usecases/update_class_instance.dart';
import 'class_instance_event.dart';
import 'class_instance_state.dart';

class ClassInstanceBloc extends Bloc<ClassInstanceEvent, ClassInstanceState> {
  // final GetClassInstances getClassInstances;
  final GenerateWeekClassInstances generateWeekClassInstances;
  final CreateClassInstance createClassInstance;
  final UpdateClassInstance updateClassInstance;
  final DeleteClassInstance deleteClassInstance;

  ClassInstanceBloc({
    // required this.getClassInstances,
    required this.generateWeekClassInstances,
    required this.createClassInstance,
    required this.updateClassInstance,
    required this.deleteClassInstance,
  }) : super(ClassInstanceInitial()) {
    on<LoadClassInstancesEvent>((event, emit) async {
      emit(ClassInstanceLoading());

      try {
        await _reloadClassInstances(
          emit,
          event.scheduleId,
          event.startTime,
          event.endTime,
        );
      } catch (e) {
        emit(ClassInstanceError(e.toString()));
      }
    });

    on<CreateClassInstanceEvent>((event, emit) async {
      if (state is! ClassInstanceLoaded) return;
      final currentState = state as ClassInstanceLoaded;

      emit(ClassInstanceLoading());

      try {
        await createClassInstance(event.classInstance);
        await _reloadClassInstances(
          emit,
          currentState.scheduleId,
          currentState.startTime,
          currentState.endTime,
        );
      } catch (e) {
        emit(ClassInstanceError(e.toString()));
      }
    });

    on<UpdateClassInstanceEvent>((event, emit) async {
      if (state is! ClassInstanceLoaded) return;
      final currentState = state as ClassInstanceLoaded;

      emit(ClassInstanceLoading());

      try {
        await updateClassInstance(event.classInstance);
        await _reloadClassInstances(
          emit,
          currentState.scheduleId,
          currentState.startTime,
          currentState.endTime,
        );
      } catch (e) {
        emit(ClassInstanceError(e.toString()));
      }
    });

    on<DeleteClassInstanceEvent>((event, emit) async {
      if (state is! ClassInstanceLoaded) return;
      final currentState = state as ClassInstanceLoaded;

      emit(ClassInstanceLoading());
      try {
        await deleteClassInstance(event.classInstanceId);
        await _reloadClassInstances(
          emit,
          currentState.scheduleId,
          currentState.startTime,
          currentState.endTime,
        );
      } catch (e) {
        emit(ClassInstanceError(e.toString()));
      }
    });
  }

  Future<void> _reloadClassInstances(
    Emitter<ClassInstanceState> emit,
    String scheduleId,
    DateTime startTime,
    DateTime endTime,
  ) async {
    // final classInstanceList = await getClassInstances(
    //   scheduleId: scheduleId,
    //   startTime: startTime,
    //   endTime: endTime,
    // );
    final classInstanceList = await generateWeekClassInstances(
      scheduleId: scheduleId,
      weekStart: startTime,
      weekEnd: endTime,
    );
    emit(
      ClassInstanceLoaded(
        classInstanceList: classInstanceList,
        scheduleId: scheduleId,
        startTime: startTime,
        endTime: endTime,
      ),
    );
  }
}
