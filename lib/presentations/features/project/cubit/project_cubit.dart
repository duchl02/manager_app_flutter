import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_state.dart';
part 'project_cubit.freezed.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit() : super(ProjectState.initial());
}
