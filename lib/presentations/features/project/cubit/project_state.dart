part of 'project_cubit.dart';

enum ProjectStatus { success, loading, failed }

@freezed
class ProjectState with _$ProjectState {
  ProjectState._();
  factory ProjectState({ required ProjectStatus status}) =
      _ProjectState;
  factory ProjectState.initial() {
          return ProjectState( status: ProjectStatus.success);
  }
  bool get isLoading =>
      status == ProjectStatus.loading;
}
